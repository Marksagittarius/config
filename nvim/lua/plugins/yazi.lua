-- ╭──────────────────────────────────────────────────────────────────╮
-- │ Yazi 文件管理器 — 与 nvim 深度集成                                  │
-- │                                                                   │
-- │ · 在 nvim 内浮窗打开 yazi（终端文件管理器，与独立 yazi 共用配置）    │
-- │ · 配色：终端里的 yazi 用 everforest-mocha flavor；nvim 浮窗边框 /  │
-- │   高亮也用 everforest 调色板，两边观感统一。                  │
-- │ · 在 yazi 中悬停的文件会在 nvim 对应 buffer 高亮（空间感知）。       │
-- │ · 在 yazi 里改名 / 移动 / 删除文件，nvim buffer 与 LSP 自动同步。    │
-- │ · <C-s> 调 snacks.picker（LazyVim 自带）在当前目录 grep；           │
-- │   <C-q> 多选发 quickfix；<C-v>/<C-x>/<C-t> 分屏/新标签打开。        │
-- │                                                                   │
-- │ 命令: :Yazi  :Yazi cwd  :Yazi toggle     体检: :checkhealth yazi    │
-- ╰──────────────────────────────────────────────────────────────────╯

-- everforest 调色板（与 colorscheme.lua / lualine.lua 一致）
local C = {
  base = "#272e33",
  mantle = "#272e33",
  surface0 = "#2d353b",
  surface1 = "#343f44",
  text = "#d3c6aa",
  blue = "#7fbbb3",
  mauve = "#d699b6",
  green = "#a7c080",
  peach = "#e69875",
  red = "#e67e80",
}

return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  version = "*", -- 跟随最新稳定版
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    -- 打开 yazi（定位到当前文件）。<leader>fy = "Find with Yazi"，归入 LazyVim 的 <leader>f 选择器前缀。
    {
      "<leader>fy",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Yazi: open file manager (at current file)",
    },
    -- 在 nvim 当前工作目录(cwd)打开 yazi
    {
      "<leader>fY",
      "<cmd>Yazi cwd<cr>",
      desc = "Yazi: open in nvim working directory (cwd)",
    },
    -- 恢复上次 yazi 会话
    {
      "<leader>yy",
      "<cmd>Yazi toggle<cr>",
      desc = "Yazi: resume last session",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    -- yazi 浮窗缩放系数（1=100%）。0.925 留出一圈终端毛玻璃边，又不至于太小。
    floating_window_scaling_factor = 0.925,
    -- winblend：0 = 不透明（清晰）。与终端玻璃风不冲突——浮窗内是 yazi 自己的底色。
    yazi_floating_window_winblend = 0,
    -- 圆角边框
    yazi_floating_window_border = "rounded",

    -- 不用 yazi 顶替 netrw（保持 LazyVim 默认 explorer 行为；yazi 作为按需浮窗）。
    open_for_directories = false,

    -- 关闭 yazi 且未选文件时，是否把 nvim cwd 切到 yazi 所在目录。
    -- 默认关闭，避免意外改工作目录；需要时可在 yazi 内按 <c-\> 临时改。
    change_neovim_cwd_on_close = false,

    -- 把可见分屏作为 yazi 标签打开，便于在多个已打开文件间快速跳转。
    open_multiple_tabs = true,

    -- 悬停 buffer 的高亮 —— everforest mocha mauve 虚线下划线（无粗体/斜体，贴合扁平风）。
    highlight_groups = {
      hovered_buffer = { underline = true, sp = C.mauve },
      hovered_buffer_in_same_directory = { underline = true, sp = C.surface1 },
    },

    keymaps = {
      show_help = "<f1>",
      open_file_in_vertical_split = "<c-v>",
      open_file_in_horizontal_split = "<c-x>",
      open_file_in_tab = "<c-t>",
      grep_in_directory = "<c-s>", -- 走 snacks.picker(LazyVim) / telescope / fzf-lua 自动探测
      replace_in_directory = false, -- 未装 grug-far，先关掉
      cycle_open_buffers = "<tab>",
      copy_relative_path_to_selected_files = "<c-y>",
      send_to_quickfix_list = "<c-q>",
      change_working_directory = "<c-\\>",
      open_and_pick_window = "<c-o>",
    },
  },
  config = function(_, opts)
    require("yazi").setup(opts)

    -- 浮窗配色：yazi.nvim 内部 winhl=NormalFloat:YaziFloat,FloatBorder:YaziFloatBorder
    -- （见 window.lua：默认 YaziFloat→Normal、YaziFloatBorder→FloatBorder）。
    -- 我们把边框染成 everforest blue（与 lualine NORMAL 徽章 / yazi flavor 强调色一致），
    -- 背景跟随 everforest 的 Normal/NormalFloat（你的 colorscheme.lua 在透明模式已设为 NONE），
    -- 这样浮窗终端区域(yazi flavor 着色)与边框都融入整体玻璃风。
    local function set_hl()
      local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
      local bg = normal_bg and string.format("#%06x", normal_bg) or "NONE"
      vim.api.nvim_set_hl(0, "YaziFloat", { bg = bg, fg = C.text })
      vim.api.nvim_set_hl(0, "YaziFloatBorder", { bg = bg, fg = C.blue })
    end
    set_hl()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("yazi_everforest", { clear = true }),
      callback = set_hl,
    })
  end,
}

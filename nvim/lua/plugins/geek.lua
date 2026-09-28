-- 极客视觉增强包：动效 / 彩虹括号 / 颜色渲染 / 滚动条 / 上下文 / 搜索计数 / 专注模式 / 彩蛋
-- 全部沿用扁平风格（不引入粗体/斜体），只靠动效与配色制造酷炫感。

return {

  -- ── 光标拖尾动画：终端里也能有鼠标般丝滑的光标 smear 效果 ──────────────
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      -- ── 流畅度：对齐 Ghostty 高刷屏（保持 120fps，这是“流畅”的关键）──
      time_interval = 8,            -- 帧间隔 8ms≈120fps
      -- ── 手感：保留肉眼可见的丝滑拖尾（stiffness 不要过高，否则拖尾会被“吃掉”看不见）──
      stiffness = 0.65,             -- 头部跟随硬度（默认 0.6），略快但保留拖尾
      trailing_stiffness = 0.4,     -- 尾部柔软度（默认 0.45，调低=拖尾更明显、更顺滑）
      damping = 0.9,                -- 阻尼（默认 0.85），轻微抑制过度晃动
      trailing_exponent = 2,        -- 中段更贴近拖尾，观感更连贯
      stiffness_insert_mode = 0.55,
      trailing_stiffness_insert_mode = 0.45,
      damping_insert_mode = 0.9,
      distance_stop_animating = 0.1,  -- 贴得足够近才停（默认值），保证收尾动画完整可见
      -- ── 行为 ──
      smear_between_buffers = true,
      smear_between_neighbor_lines = false,  -- 滚动时避免与 neoscroll 抢重绘（卡顿元凶之一）
      smear_insert_mode = true,
      legacy_computing_symbols_support = false, -- Maple Mono NF CN 不提供 legacy 块状符号，关掉避免回退渲染
    },
  },

  -- ── 丝滑滚动：Ctrl-d/u、zz、搜索跳转平滑过渡 ───────────────────────────
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      local neoscroll = require("neoscroll")
      neoscroll.setup({
        -- 缓动函数，越靠后越"减速"，观感更高级
        easing = "quadratic",
        cursor_scrolls_alone = true,
        hide_cursor = true,
      })
      -- 新版 helper API（set_mappings 已废弃）
      local function s(lines, opts)
        return function()
          neoscroll.scroll(lines, opts)
        end
      end
      local map = vim.keymap.set
      local ctrl_u, ctrl_d = "<C-u>", "<C-d>"
      -- 时长 ms：越大越舒缓。半屏 260 / 整屏 380 / 微调 140（更"电影感"但不拖沓）
      map({ "n", "x" }, ctrl_d, s(vim.wo.scroll, { move_cursor = true, duration = 260 }), { desc = "Scroll down (smooth)" })
      map({ "n", "x" }, ctrl_u, s(-vim.wo.scroll, { move_cursor = true, duration = 260 }), { desc = "Scroll up (smooth)" })
      map({ "n", "x" }, "<C-b>", s(-vim.api.nvim_win_get_height(0), { move_cursor = true, duration = 380 }))
      map({ "n", "x" }, "<C-f>", s(vim.api.nvim_win_get_height(0), { move_cursor = true, duration = 380 }))
      map({ "n", "x" }, "<C-e>", s(0.10, { move_cursor = false, duration = 140 }))
      map({ "n", "x" }, "<C-y>", s(-0.10, { move_cursor = false, duration = 140 }))
      -- zt/zz/zb：居中重定向，带轻微动画
      map("n", "zt", function() neoscroll.zt(220) end)
      map("n", "zz", function() neoscroll.zz(220) end)
      map("n", "zb", function() neoscroll.zb(220) end)
    end,
  },

  -- ── 窗口开合 / resize 动画（滚动与光标交给上面两位，避免重复打架）──────
  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- 不与 neoscroll / smear-cursor 重复
      local animate = require("mini.animate")
      return {
        resize = { enable = true, timing = animate.gen_timing.linear({ duration = 120, unit = "total" }) },
        close = { enable = true },
        open = { enable = true },
        scroll = { enable = false },
        cursor = { enable = false },
      }
    end,
  },

  -- ── 彩虹括号：嵌套括号按层级自动变色，一眼看清作用域 ───────────────────
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow.strategy["local"],
          vim = rainbow.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  -- ── 颜色码可视化：#fff / rgb() / hsl() 直接在代码里显示真实颜色色块 ────
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      render = "background",   -- background | foreground | virtual | first_column
      enable_named_colors = true,
      enable_tailwind = true,
    },
  },

  -- ── 右侧滚动条 + git 增删标记 + 搜索位置标记 ──────────────────────────
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      show_in_active_only = true,
      handle = { highlight = "CursorColumn" },
      marks = {
        GitAdd = { text = "▕" },
        GitChange = { text = "▕" },
        GitDelete = { text = "▏" },
        Search = { color = "#d699b6" },
      },
      handlers = {
        gitsigns = true,
        search = true,
        diagnostic = true,
      },
    },
  },

  -- ── 上下文：滚动时在顶部"钉住"当前所在函数/类的签名 ───────────────────
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
      max_lines = 4,          -- 上下文最多占几行
      min_window_height = 20,
      multiline_threshold = 3,
      line_numbers = true,
      separator = "─",
      -- 用 everforest 风格颜色（扁平、无粗体）
    },
  },

  -- ── 搜索计数：n/N 时显示 "当前第 x 个 / 共 y 个"，并联动滚动条 ────────
  {
    "kevinhwang91/nvim-hlslens",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "n",  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]], desc = "Next search (centered)" },
      { "N",  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]], desc = "Prev search (centered)" },
      { "*",  [[*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word under cursor *" },
      { "#",  [[#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word under cursor #" },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], desc = "g*" },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], desc = "g#" },
    },
    opts = {
      calm_down = true,
      nearest_only = false,
      nearest_float_when = "auto",
      override_lens = function(render, posList, nearest, idx, _)
        local lnum, col = unpack(posList[idx])
        local text = (" [%d/%d] "):format(idx, #posList)
        local chunks = { { text, "HlSearchLens" } }
        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
      end,
    },
  },

  -- ── 专注模式：<leader>z 进入禅模式（居中、隐藏干扰），Twilight 弱化无关代码
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = { { "<leader>z", "<Cmd>ZenMode<CR>", desc = "Zen Mode" } },
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = { number = false, relativenumber = false, signcolumn = "no" },
      },
      plugins = {
        options = { enabled = true, ruler = false, showcmd = false },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
      },
    },
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "ZenMode" },
    opts = { dimming = { inactive = true }, context = 15 },
  },

  -- ── 彩蛋：代码"生命游戏" / make it rain ───────────────────────────────
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = { { "<leader>fml", "<Cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain (easter egg)" } },
  },
}

-- everforest 主题 + 统一字重（禁用粗体/斜体）+ 透明背景开关
-- 透明总开关：true = 玻璃毛玻璃效果（需终端自带透明/模糊）；false = 实心底色
local TRANSPARENT = true

-- everforest 配色锚点（dark 色板，用于透明模式下浮窗边框等兜底覆盖）
local EF = {
  fg = "#d3c6aa",
  bg = "#2d353b",
  bg2 = "#343f44",
  bg4 = "#475258",
  gray = "#859289",
  gray_dim = "#7a8478",
  red = "#e67e80",
  orange = "#e69875",
  yellow = "#dbbc7f",
  green = "#a7c080",
  cyan = "#83c092",
  blue = "#7fbbb3",
  purple = "#d699b6",
}

return {
  {
    dir = vim.fn.expand("~/.config/nvim/everforest.nvim"),
    lazy = false,
    priority = 1000,
    name = "everforest",
    config = function()
      -- everforest 选项（见 everforest.nvim/doc/everforest.txt）
      vim.g.everforest_background = "medium" -- 背景对比度 hard | medium | soft
      vim.g.everforest_ui_contrast = 1 -- 侧边栏 / 浮窗更高对比
      vim.g.everforest_transparent_background = TRANSPARENT and 1 or 0 -- 主背景透明
      vim.g.everforest_enable_italic = 0 -- 全局禁用斜体
      vim.g.everforest_disable_italic_comment = 1 -- 注释也不斜体
      vim.g.everforest_better_performance = 1
      vim.g.everforest_float_style = "bright" -- 浮窗亮背景

      vim.cmd.colorscheme("everforest")

      -- 透明模式：把残留底色的面板 / 浮窗也清成透明（保留毛玻璃质感）
      local function set_transparent()
        if not TRANSPARENT then
          return
        end
        local groups = {
          "Normal", "NormalNC", "NormalFloat", "SignColumn",
          "StatusLine", "StatusLineNC", "TabLine", "TabLineFill",
          "WinBar", "WinBarNC", "Pmenu", "PmenuSel",
          "SnacksNormal", "SnacksPicker", "TreesitterContext",
        }
        for _, g in ipairs(groups) do
          local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = g })
          if ok and hl then
            hl.bg = "NONE"
            vim.api.nvim_set_hl(0, g, hl)
          end
        end
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = EF.gray_dim, bg = "NONE" })
      end

      -- 统一字重：关键面板组显式清粗体 / 斜体（兜底，everforest 本身无粗体风格）
      local function flatten_weight()
        local groups = {
          "MasonHeading", "MasonMutedBlockBold", "MasonHighlightBlockBold",
          "MasonHighlightBlockBoldSecondary", "SnacksDashboardIcon", "DashboardIcon",
        }
        for _, g in ipairs(groups) do
          local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = g })
          if ok and hl then
            hl.bold = false
            hl.italic = false
            vim.api.nvim_set_hl(0, g, hl)
          end
        end
      end

      set_transparent()
      flatten_weight()

      -- ColorScheme 事件后重应用（覆盖第三方集成 / LazyVim 重新设置残留）
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          set_transparent()
          flatten_weight()
        end,
      })
    end,
  },
  -- 让 LazyVim 用 everforest 作为默认配色
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}

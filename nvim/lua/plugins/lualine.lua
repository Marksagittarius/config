-- lualine 状态栏：极客电源线条（slanted powerline），everforest 配色
-- 全程无粗体/斜体，靠色块与斜切分隔符制造层次。
-- GLASS=true 时中性段落透明（配合终端毛玻璃），仅保留几个高对比徽章为实色。

local GLASS = true -- 与 colorscheme.lua 的 TRANSPARENT 保持一致

local mocha = {
  pink = "##d699b6",
  mauve = "##d699b6",
  red = "##e67e80",
  peach = "##e69875",
  yellow = "##dbbc7f",
  green = "##a7c080",
  teal = "##83c092",
  sapphire = "##7fbbb3",
  blue = "##7fbbb3",
  lavender = "##7fbbb3",
  text = "##d3c6aa",
  subtext1 = "##859289",
  surface2 = "##343f44",
  surface1 = "##343f44",
  surface0 = "##2d353b",
  base = "##272e33",
  mantle = "##272e33",
}

-- 斜切电源分隔符
local slant = { left = "", right = "" }
local slant_thin = { left = "", right = "" }

-- 玻璃模式下中性块的底色（透明）
local bg0 = GLASS and "NONE" or mocha.mantle
local bg1 = GLASS and "NONE" or mocha.surface0

-- ── Git ahead / behind（带 5 秒缓存，避免每条状态栏都跑 git）─────────────
local git_cache = { ttl = 5 }
local function git_ahead_behind()
  local cwd = vim.fn.getcwd()
  local now = os.time()
  local c = git_cache[cwd]
  if c and (now - c.at) < git_cache.ttl then
    return c.out
  end
  local out = ""
  local ok, res = pcall(function()
    local r = vim.fn.system({
      "git", "-C", cwd, "rev-list", "--left-right", "--count", "@{upstream}...HEAD",
    })
    return vim.trim(r or "")
  end)
  if ok and res and res ~= "" and not res:find("fatal") then
    local behind, ahead = res:match("(%d+)%s+(%d+)")
    if ahead and behind then
      local parts = {}
      if tonumber(ahead) and tonumber(ahead) > 0 then
        parts[#parts + 1] = "%#LualineGitAhead# 󰜘 " .. ahead .. " "
      end
      if tonumber(behind) and tonumber(behind) > 0 then
        parts[#parts + 1] = "%#LualineGitBehind# 󰜓 " .. behind .. " "
      end
      out = table.concat(parts)
    end
  end
  git_cache[cwd] = { at = now, out = out }
  return out
end

-- 模式 → 文字 / 颜色
local mode_map = {
  n      = { "  NORMAL ", mocha.blue },
  i      = { "  INSERT ", mocha.green },
  v      = { "  VISUAL ", mocha.mauve },
  V      = { "  V-LINE ", mocha.mauve },
  [""] = { "  V-BLOCK", mocha.mauve },
  c      = { "  COMMAND", mocha.peach },
  R      = { "  REPLACE", mocha.red },
  t      = { "  TERM   ", mocha.teal },
}

local function mode_component()
  local m = vim.fn.mode()
  local info = mode_map[m] or { "  " .. m:upper() .. " ", mocha.blue }
  return info[1], info[2]
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts)
    -- ahead/behind 专用高亮（玻璃模式下底透明，仅绿/红前景）
    vim.api.nvim_set_hl(0, "LualineGitAhead", { fg = mocha.green, bg = bg1 })
    vim.api.nvim_set_hl(0, "LualineGitBehind", { fg = mocha.red, bg = bg1 })

    -- 玻璃模式下所有段落底色透明（NONE）；lualine 要求每个模式都有完整的 a/b/c 三段，
    -- 否则缺段（如 b 段 mode 徽章）渲染时会拿不到高亮组而报错。
    local function glass_section(fg)
      return {
        a = { fg = fg, bg = bg0, gui = "" },
        b = { fg = fg, bg = bg0, gui = "" },
        c = { fg = fg, bg = bg0, gui = "" },
      }
    end

    opts.options = {
      theme = {
        normal   = glass_section(mocha.text),
        insert   = glass_section(mocha.green),
        visual   = glass_section(mocha.mauve),
        replace  = glass_section(mocha.red),
        command  = glass_section(mocha.peach),
        terminal = glass_section(mocha.teal),
        inactive = glass_section(mocha.surface2),
      },
      globalstatus = true,
      component_separators = "",
      section_separators = "",
      always_divide_middle = true,
    }

    -- 模式徽章（实色，保持高对比）。文字/颜色在渲染时动态获取，随模式切换更新。
    local mode = {
      function()
        local text = mode_component()
        return text
      end,
      color = function()
        local _, c = mode_component()
        return { fg = mocha.base, bg = c, gui = "" }
      end,
      separator = { left = "", right = slant.left },
    }

    local branch = {
      "branch",
      icon = " ",
      color = { fg = mocha.pink, bg = bg1, gui = "" },
      separator = { left = "", right = slant_thin.left },
    }

    -- ahead / behind（放在分支后，半透明底）
    local aheadbehind = {
      git_ahead_behind,
      color = { bg = bg1, gui = "" },
      separator = { left = "", right = slant.left },
      draw_empty = false,
    }

    local diff = {
      "diff",
      diff_color = {
        added = { fg = mocha.green, bg = bg1 },
        modified = { fg = mocha.yellow, bg = bg1 },
        removed = { fg = mocha.red, bg = bg1 },
      },
      symbols = { added = " +", modified = " ~", removed = " -" },
      colored = true,
      color = { bg = bg1 },
      separator = { left = "", right = slant.left },
    }

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ✖ ", warn = " ▲ ", info = " ℹ ", hint = " ◆ " },
      diagnostics_color = {
        error = { fg = mocha.red },
        warn = { fg = mocha.yellow },
        info = { fg = mocha.sapphire },
        hint = { fg = mocha.teal },
      },
      color = { bg = bg0, gui = "" },
    }

    local lsp = {
      function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local names = {}
        for _, c in ipairs(clients) do
          if c.name ~= "null-ls" then
            table.insert(names, c.name)
          end
        end
        return #names > 0 and ("  " .. table.concat(names, ", ")) or ""
      end,
      icon = "⚡",
      color = { fg = mocha.mauve, bg = bg1, gui = "" },
      separator = { left = slant.right, right = "" },
    }

    local filetype = {
      "filetype",
      colored = true,
      color = { fg = mocha.text, bg = bg1, gui = "" },
      separator = { left = slant_thin.right, right = "" },
    }

    local progress = {
      "progress",
      fmt = function(str)
        return str .. " "
      end,
      color = { fg = mocha.surface2, bg = bg0, gui = "" },
      separator = { left = slant.right, right = "" },
    }

    local location = {
      "location",
      icon = "",
      color = { fg = mocha.base, bg = mocha.lavender, gui = "" },
      separator = { left = slant.right, right = slant.right },
      fmt = function(s)
        return " " .. s .. " "
      end,
    }

    -- 时钟徽章：Nerd 时钟图标 + 24 小时制 + 星期
    local clock = {
      function()
        return " 󰥔 " .. os.date("%H:%M ") .. os.date("%a"):sub(1, 2) .. " "
      end,
      color = { fg = mocha.base, bg = mocha.peach, gui = "" },
      separator = { left = "", right = "" },
    }

    opts.sections = {
      lualine_a = {},
      lualine_b = { mode },
      lualine_c = {
        branch,
        aheadbehind,
        diff,
        diagnostics,
        {
          function()
            return "%="
          end,
          color = { bg = bg0 },
        },
        {
          "filename",
          path = 1,
          color = { fg = mocha.text, bg = bg0, gui = "" },
          symbols = { modified = " ● ", readonly = " 󰌾 ", unnamed = "[no name]" },
        },
      },
      lualine_x = {
        lsp,
        filetype,
        progress,
        location,
        clock,
      },
      lualine_y = {},
      lualine_z = {},
    }

    opts.tabline = nil
    opts.extensions = { "lazy", "mason", "trouble", "fzf", "nvim-tree" }
    return opts
  end,
}

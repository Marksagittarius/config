-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- 缩进：4 空格（Go/Python/C/Java 项目为主）
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 性能：降低交换/更新频率，大数据文件更流畅
opt.updatetime = 200
opt.timeoutlen = 300

-- UI
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes" -- 避免 git/lsp 诊断符号抖动

-- 剪贴板与系统
opt.clipboard = "unnamedplus"

-- 撤销持久化（重启后仍可撤销）
opt.undofile = true

-- 分屏新窗口位置
opt.splitbelow = true
opt.splitright = true

-- 折叠（LazyVim 默认装了 nvim-ufo 时用此设置）
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

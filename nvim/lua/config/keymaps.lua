-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- jk 快速退出插入模式
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- 保存
map({ "i", "n" }, "<C-s>", "<Cmd>w<Cr>", { desc = "Save file" })

-- 移动行/块（可视模式）
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- 居中跳转
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzv", { desc = "Prev search result (centered)" })

-- 快速关闭当前 buffer
map("n", "<leader>bd", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Delete Buffer" })

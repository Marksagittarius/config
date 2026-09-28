-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 兜底：清除所有高亮组的粗体/斜体，保证全局字重一致
-- 1) ColorScheme：主题加载/切换后清理一次
-- 2) 定期兜底：lualine/bufferline 等插件会在主题加载后动态生成带 gui=bold 的高亮组，
--    通过 User LazyRender（每次 lazy 界面刷新触发）与 UIEnter 再清理
local function strip_bold_italic()
  for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
    if hl.bold or hl.italic then
      hl.bold = nil
      hl.italic = nil
      vim.api.nvim_set_hl(0, name, hl)
    end
  end
end

local group = vim.api.nvim_create_augroup("user_uniform_weight", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "*",
  callback = strip_bold_italic,
  desc = "Strip bold/italic from all highlight groups",
})
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = { "LazyRender", "VeryLazy" },
  callback = strip_bold_italic,
  desc = "Strip bold/italic after plugin UI highlights are generated",
})
vim.api.nvim_create_autocmd("UIEnter", {
  group = group,
  pattern = "*",
  callback = strip_bold_italic,
  desc = "Final bold/italic sweep after UI is ready",
})

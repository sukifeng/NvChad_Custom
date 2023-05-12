-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
if vim.g.neovide then
    -- vim.o.guifont = "FiraMono Nerd Font:h10"
    vim.o.guifont = "Hack NF:h12"
    vim.g.neovide_profiler = false
end
--自动切换输入法
vim.cmd([[
 autocmd VimEnter * :silent :!e:\\Neovim\\tools\\im-select.exe 1033
"autocmd InsertEnter * :silent :!e:\\Neovim\\tools\\im-select.exe 2052
 autocmd InsertLeave * :silent :!e:\\Neovim\\tools\\im-select.exe 1033
"autocmd VimLeave * :silent :!e:\\Neovim\\tools\\im-select.exe 2052
]])

--自动切换目录
vim.o.autochdir = true

---@type MappingsTable
local M = {}

vim.cmd([[
  function! OpenFolder()
      execute "silent !start explorer.exe /select, " . shellescape(expand('%'),1)
  endfunction
]])
M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>w"] = { "<cmd> w <CR>", "save file" },
    ["<leader>a"] = { ":call OpenFolder()<CR>", "open in folder" },
  },
}

-- more keybinds!

return M

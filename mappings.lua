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
        ["<leader>o"] = { "<cmd> SymbolsOutline<CR>", "SymbolsOutline" },
    }
}
M.disabled = {
    n = {
        ["<leader>wa"] = "",
        ["<leader>wK"] = "",
        ["<leader>wk"] = "",
        ["<leader>wl"] = "",
        ["<leader>wr"] = "",
        ["<leader>f"] = ""
    }
}
M.telescope = {
    n = {
        ["<leader>fs"] = { "<cmd> Telescope grep_string<CR>", "grep_string" },
        ["<leader>fp"] = { "<cmd> Telescope projects<CR>", "projects" },
    },
}
return M

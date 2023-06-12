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
        ["<leader>bn"] = { "<cmd> enew <CR>", "New buffer" },
        ["<leader>bf"] = { function()
            vim.lsp.buf.format{async = false}
            vim.cmd('w')
        end ,
        "buffer format" },
    }
}
M.disabled = {
    n = {
        ["<leader>wa"] = "",
        ["<leader>wK"] = "",
        ["<leader>wk"] = "",
        ["<leader>wl"] = "",
        ["<leader>wr"] = "",
        ["<leader>f"] = "",
        ["<leader>b"] = "",
    }
}
M.telescope = {
    n = {
        ["<leader>fg"] = { "<cmd> Telescope grep_string<CR>", "grep_string" },
        ["<leader>fp"] = { "<cmd> Telescope projects<CR>", "projects" },
        ["<leader>fc"] = { "<cmd> Telescope lsp_outgoing_calls<CR>", "who call the function" },
        ["<leader>fs"] = { "<cmd> Telescope treesitter<CR>", "symbols" },
    },
}
return M

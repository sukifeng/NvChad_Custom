local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require "custom.configs.null-ls"
                end,
            },
        },
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },

    -- override plugin configs
    {
        "williamboman/mason.nvim",
        opts = overrides.mason
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },

    -- Install a plugin
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        cmd = {"TroubleToggle"},
        init = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
            vim.keymap.set("n", "<leader>tx", "<cmd>TroubleToggle<cr>",
                {silent = true, noremap = true}
            )
            vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
                {silent = true, noremap = true}
            )
            vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",
                {silent = true, noremap = true}
            )
            vim.keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>",
                {silent = true, noremap = true}
            )
            vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",
                {silent = true, noremap = true}
            )
            vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
                {silent = true, noremap = true}
            )
            --local actions = require("telescope.actions")
            local trouble = require("trouble.providers.telescope")

            local telescope = require("telescope")

            telescope.setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<c-t>"] = trouble.open_with_trouble,
                            ["<C-j>"] = require('telescope.actions').move_selection_next,
                            ["<C-k>"] = require('telescope.actions').move_selection_previous,
                        },
                        n = { ["<c-t>"] = trouble.open_with_trouble },
                    },
                },
            }
        end
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure()
        end,
        lazy = false
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                patterns = { ".git", "*.eww", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                silent_chdir = true,
                detection_methods = {  "pattern","lsp" }, 

                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
            require("nvim-tree").setup({
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true
                },
            })
            require('telescope').load_extension('projects')
        end,
        event = "VimEnter",
        cmd = "Telescope projects"
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = {
            defaults = {
                file_ignore_patterns = {
                    ".git/",
                    ".svn/*",
                    "setting/*",
                    "documents/*",
                    ".history/*",
                    "Obj/*",
                    "target/",
                    "docs/",
                    "vendor/*",
                    "%.lock",
                    "__pycache__/*",
                    "%.sqlite3",
                    "%.ipynb",
                    "node_modules/*",
                    -- "%.jpg",
                    -- "%.jpeg",
                    -- "%.png",
                    "%.svg",
                    "%.otf",
                    "%.ttf",
                    "%.webp",
                    ".dart_tool/",
                    ".github/",
                    ".gradle/",
                    ".idea/",
                    ".settings/",
                    ".vscode/",
                    "__pycache__/",
                    "doxygen/*",
                    "build/",
                    "env/",
                    "gradle/",
                    "node_modules/",
                    "%.pdb",
                    "%.dll",
                    "%.class",
                    "%.exe",
                    "%.cache",
                    "%.ico",
                    "%.pdf",
                    "%.dylib",
                    "%.jar",
                    "%.docx",
                    "%.met",
                    "smalljre_*/*",
                    ".vale/",
                    "%.burp",
                    "%.mp4",
                    "%.mkv",
                    "%.rar",
                    "%.zip",
                    "%.7z",
                    "%.tar",
                    "%.bz2",
                    "%.epub",
                    "%.flac",
                    "%.out",
                    "%.sim",
                    "%.dep",
                    "%.ewp",
                    "%.ewd",
                    "%.ewt",
                    "%.tar.gz",
                },
            }
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        -- "Lunarvim/lualine.nvim",
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch',
                        {
                            'diff',
                            colored = false, -- Displays a colored diff status if set to true
                            diff_color = {
                                -- Same color values as the general color option can be used here.
                                added    = 'DiffAdd',    -- Changes the diff's added color
                                modified = 'DiffChange', -- Changes the diff's modified color
                                removed  = 'DiffDelete', -- Changes the diff's removed color you
                            },
                            symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
                            source = nil, -- A function that works as a data source for diff.
                            -- It must return a table as such:
                            --   { added = add_count, modified = modified_count, removed = removed_count }
                            -- or nil on failure. count <= 0 won't be displayed.
                        },
                    'diagnostics'},
                lualine_c = {{'filename', path = 2}},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end,
        event = "VimEnter",
    },
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup{
                keymaps = {
                    goto_location = {"<cr>",'<2-LeftMouse>'},
                }
            }
        end,
        cmd = {'SymbolsOutline','SymbolsOutlineOpen'},
    }
    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },

    -- All NvChad plugins are lazy-loaded by default
    -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
    -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
    -- {
    --   "mg979/vim-visual-multi",
    --   lazy = false,
    -- }
}

return plugins

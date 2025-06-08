return {
    {
        "nvim-tree/nvim-web-devicons",
        opts = {
            override = {
                copilot = {
                    icon = "",
                    color = "#cba6f7", -- Catppuccin.mocha.mauve
                    name = "Copilot",
                },
            },
        },
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
            { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
            { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
            { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
            { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
            { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
            { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
        },
        opts = {
            options = {
                -- stylua: ignore
                close_command = function(n) Snacks.bufdelete(n) end,
                -- stylua: ignore
                right_mouse_command = function(n) Snacks.bufdelete(n) end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    local icons = LazyVim.config.icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                    {
                        filetype = "snacks_layout_box",
                    },
                },
                ---@param opts bufferline.IconFetcherOpts
                get_element_icon = function(opts)
                    return LazyVim.config.icons.ft[opts.filetype]
                end,
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "AndreM222/copilot-lualine",
        },
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            -- PERF: we don't need this lualine require madness 🤷
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            local icons = LazyVim.config.icons

            vim.o.laststatus = vim.g.lualine_laststatus

            local opts = {
                options = {
                    theme = "auto",
                    globalstatus = vim.o.laststatus == 3,
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },

                    lualine_c = {
                        LazyVim.lualine.root_dir(),
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        { "filetype",                   icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { LazyVim.lualine.pretty_path() },
                    },
                    lualine_x = {
                        {
                            function()
                                local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
                                if #buf_clients == 0 then
                                    return ""
                                end
                                
                                local buf_client_names = {}
                                for _, client in pairs(buf_clients) do
                                    table.insert(buf_client_names, client.name)
                                end
                    
                                local lsp_status = require('lsp-status')
                                local status = lsp_status.status()
                                
                                -- Combine LSP server names with status
                                return string.format("󰒋 [%s] %s", 
                                    table.concat(buf_client_names, ", "),
                                    status
                                )
                            end,
                            -- icon = ' LSP:',
                            -- color = { fg = '#ffffff', gui = 'bold' }
                        },
                        Snacks.profiler.status(),
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.command.get() end,
                            cond = function() return package.loaded["noice"] and
                                require("noice").api.status.command.has() end,
                            color = function() return { fg = Snacks.util.color("Statement") } end,
                        },
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                            color = function() return { fg = Snacks.util.color("Constant") } end,
                        },
                        -- stylua: ignore
                        {
                            function() return "  " .. require("dap").status() end,
                            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                            color = function() return { fg = Snacks.util.color("Debug") } end,
                        },
                        -- stylua: ignore
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = function() return { fg = Snacks.util.color("Special") } end,
                        },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                            source = function()
                                local gitsigns = vim.b.gitsigns_status_dict
                                if gitsigns then
                                    return {
                                        added = gitsigns.added,
                                        modified = gitsigns.changed,
                                        removed = gitsigns.removed,
                                    }
                                end
                            end,
                        },
                    },
                    lualine_y = {
                        { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        function()
                            return " " .. os.date("%R")
                        end,
                    },
                },
                extensions = { "neo-tree", "lazy", "fzf" },
            }

            -- do not add trouble symbols if aerial is enabled
            -- And allow it to be overriden for some buffer types (see autocmds)
            if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
                local trouble = require("trouble")
                local symbols = trouble.statusline({
                    mode = "symbols",
                    groups = {},
                    title = false,
                    filter = { range = true },
                    format = "{kind_icon}{symbol.name:Normal}",
                    hl_group = "lualine_c_normal",
                })
                table.insert(opts.sections.lualine_c, {
                    symbols and symbols.get,
                    cond = function()
                        return vim.b.trouble_lualine ~= false and symbols.has()
                    end,
                })
            end

            local copilot = {
                "copilot",
                show_colors = true,
            }
            table.insert(opts.sections.lualine_c, copilot)

            return opts
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>sn",  "",                                                                            desc = "+noice" },
            { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                              desc = "Redirect Cmdline" },
            { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
            { "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
            { "<leader>snt", function() require("noice").cmd("pick") end,                                   desc = "Noice Picker (Telescope/FzfLua)" },
            { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,                           expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
            { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,                           expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
        },
        config = function(_, opts)
            -- HACK: noice shows messages from before it was enabled,
            -- but this is not ideal when Lazy is installing plugins,
            -- so clear the messages in this case.
            if vim.o.filetype == "lazy" then
                vim.cmd([[messages clear]])
            end
            require("noice").setup(opts)
        end,
    },
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {
            file = {
                [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
            },
            filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    { "MunifTanjim/nui.nvim", lazy = true },
    {
        "snacks.nvim",
        opts = {
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = false }, -- we set this in options.lua
            toggle = { map = LazyVim.safe_keymap_set },
            words = { enabled = true },
        },
        -- stylua: ignore
        keys = {
            {
                "<leader>n",
                function()
                    if Snacks.config.picker and Snacks.config.picker.enabled then
                        Snacks.picker.notifications()
                    else
                        Snacks.notifier.show_history()
                    end
                end,
                desc = "Notification History"
            },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        },
    },
    {
        "snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    pick = function(cmd, opts)
                        return LazyVim.pick(cmd, opts)()
                    end,
                    header = [[
              ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
              ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
              ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
              ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
              ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
              ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
       ]],
                    -- stylua: ignore
                    ---@type snacks.dashboard.Item[]
                    keys = {
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
                        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
            },
        },
    },
    -- {
    --     "romgrk/barbar.nvim",
    --     version = "^1.0.0", -- optional: only update when a new 1.x version is released
    --     dependencies = {
    --         "lewis6991/gitsigns.nvim",
    --         "nvim-tree/nvim-web-devicons",
    --     },
    --     init = function()
    --         vim.g.barbar_auto_setup = false
    --     end,
    --     lazy = false,
    --     -- stylua: ignore
    --     keys = {
    --         { "<A-<>", "<CMD>BufferMovePrevious<CR>", mode = { "n" }, desc = "[Buffer] Move buffer left" },
    --         { "<A->>", "<CMD>BufferMoveNext<CR>",     mode = { "n" }, desc = "[Buffer] Move buffer right" },
    --         { "<A-1>", "<CMD>BufferGoto 1<CR>",       mode = { "n" }, desc = "[Buffer] Go to buffer 1" },
    --         { "<A-2>", "<CMD>BufferGoto 2<CR>",       mode = { "n" }, desc = "[Buffer] Go to buffer 2" },
    --         { "<A-3>", "<CMD>BufferGoto 3<CR>",       mode = { "n" }, desc = "[Buffer] Go to buffer 3" },
    --         { "<A-4>", "<CMD>BufferGoto 4<CR>",       mode = { "n" }, desc = "[Buffer] Go to buffer 4" },
    --         { "<A-5>", "<CMD>BufferGoto 5<CR>",       mode = { "n" }, desc = "[Buffer] Go to buffer 5" },
    --         { "<A-6>", "<CMD>BufferGoto 6<CR>",       mode = { "n" }, desc = "[Buffer] Go to buffer 6" },
    --         { "<A-7>", "<CMD>BufferGoto 7<CR>",       mode = { "n" }, desc = "[Buffer] Go to buffer 7" },
    --         { "<A-8>", "<CMD>BufferGoto 8<CR>",       mode = { "n" }, desc = "[Buffer] Go to buffer 8" },
    --         { "<A-9>", "<CMD>BufferGoto 9<CR>",       mode = { "n" }, desc = "[Buffer] Go to buffer 9" },
    --         { "<A-h>", "<CMD>BufferPrevious<CR>",     mode = { "n" }, desc = "[Buffer] Previous buffer" },
    --         { "<A-l>", "<CMD>BufferNext<CR>",         mode = { "n" }, desc = "[Buffer] Next buffer" },
    --     },
    --     opts = {
    --         animation = false,
    --         -- Automatically hide the tabline when there are this many buffers left.
    --         -- Set to any value >=0 to enable.
    --         auto_hide = 1,

    --         -- Set the filetypes which barbar will offset itself for
    --         sidebar_filetypes = {
    --             NvimTree = true, -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
    --         },
    --     },
    -- },
    {
        "HiPhish/rainbow-delimiters.nvim",
        main = "rainbow-delimiters.setup",
        submodules = false,
        opts = {},
    },
    {
        'nvim-lua/lsp-status.nvim',
        event = "VeryLazy",
        config = function()
            local lsp_status = require('lsp-status')

            -- Configure status information
            lsp_status.config({
                -- Indicator icons for different status types
                indicator_errors = 'E',
                indicator_warnings = 'W',
                indicator_info = 'I',
                indicator_hint = '?',
                indicator_ok = '✓',

                -- Component configuration
                status_symbol = 'LSP',
                component_separator = ' ',

                -- Show detailed information
                current_function = false,
                show_filename = false,
                diagnostics = false,

                -- Configure symbols for different status
                symbols = {
                    ['spinner'] = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
                    ['progress'] = { '██', '▇▇', '▆▆', '▅▅', '▄▄', '▃▃', '▂▂', '▁▁' },
                },

                -- Remove select_symbol setting as it's causing the error
                -- select_symbol = true,
                select_symbol = function(cursor_pos, symbol)
                    if symbol.valueRange then
                        local value_range = {
                            ["start"] = {
                                character = 0,
                                line = vim.fn.byte2line(symbol.valueRange[1])
                            },
                            ["end"] = {
                                character = 0,
                                line = vim.fn.byte2line(symbol.valueRange[2])
                            }
                        }

                        return require("lsp-status.util").in_range(cursor_pos, value_range)
                    end
                end,

                -- Diagnostics settings
                diagnostics_update_in_insert = false,
                diagnostics_virtual_text = true,
            })

            -- Register progress callback
            lsp_status.register_progress()

            -- Register the capabilities with error handling
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities or {})

            -- Setup on_attach with error handling
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client then
                        pcall(function()
                            lsp_status.on_attach(client)
                        end)
                    end
                end,
            })

            -- Update status on changes
            vim.cmd([[
                augroup lsp_status
                    autocmd!
                    autocmd User LspProgressUpdate redrawstatus
                    autocmd User LspStatusUpdate redrawstatus
                    autocmd BufEnter,BufWinEnter,WinEnter * redrawstatus
                augroup END
            ]])
        end
    },
    {
        -- Improves the Neovim built-in LSP experience.
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({})
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons', -- optional
        }
    },
    {
        "j-hui/fidget.nvim",
        opts = {
        },
    },
    {
        "rmagatti/goto-preview",
        dependencies = { "rmagatti/logger.nvim" },
        event = "BufEnter",
        config = true,
        opts = {
            default_mappings = false, -- Disable default mappings to use our custom ones
            post_open_hook = nil,     -- A function taking two arguments, a buffer and a window to be ran as a hook
            references_highlight = true,
            reference_highlight_priority = 100,
            preview_window_title = { enable = true, position = "left" }, -- "left|center|right"
        },
        keys = {
            -- Navigate to definition in a preview window
            {
                "gpd",
                "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
                desc = "Preview Definition",
                mode = "n"
            },
            -- Preview type definition
            {
                "gpt",
                "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
                desc = "Preview Type Definition",
                mode = "n"
            },
            -- Preview implementation
            {
                "gpi",
                "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
                desc = "Preview Implementation",
                mode = "n"
            },
            -- Preview references
            {
                "gpr",
                "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
                desc = "Preview References",
                mode = "n"
            },
            -- Close all preview windows
            {
                "gpc",
                "<cmd>lua require('goto-preview').close_all_win()<CR>",
                desc = "Close All Preview Windows",
                mode = "n"
            }
        }
    },
    { 'echasnovski/mini.diff', version = '*' },

}
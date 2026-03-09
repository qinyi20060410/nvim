-- ╭──────────────────────────────────────────────────────────╮
-- │               UI & Theme (Catppuccin)                    │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- Catppuccin colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          blink_cmp = true,
          bufferline = true,
          dashboard = true,
          dap = { enabled = true, enable_ui = true },
          flash = true,
          gitsigns = true,
          illuminate = { enabled = true },
          indent_blankline = { enabled = true },
          lsp_trouble = true,
          mason = true,
          mini = { enabled = true },
          neotree = true,
          noice = true,
          notify = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          telescope = { enabled = true },
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          return {
            -- Ensure cursor is highly visible
            Cursor = { fg = colors.base, bg = colors.text },
            lCursor = { fg = colors.base, bg = colors.text },
          }
        end,
      })
      vim.cmd("colorscheme catppuccin")

      -- Ensure cursor is always visible
      vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Better UI components
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "AndreM222/copilot-lualine" },
    opts = function()
      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", icon = "" } },
          lualine_b = { { "branch", icon = "" } },
          lualine_c = {
            {
              "diagnostics",
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 1,
              symbols = { modified = " ", readonly = " ", unnamed = " " },
            },
            {
              -- Python 虚拟环境 (Conda/Venv) 智能显示
              function()
                local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_DEFAULT_ENV
                if venv then
                  local env_name = string.match(venv, "[^/]+$")
                  return " " .. env_name
                end
                return ""
              end,
              cond = function()
                return vim.bo.filetype == "python" and (vim.env.VIRTUAL_ENV ~= nil or vim.env.CONDA_DEFAULT_ENV ~= nil)
              end,
              color = { fg = "#A6E3A1" },
            },
            { "filesize", cond = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end },
          },
          lualine_x = {
            {
              -- DAP 调试状态
              function() return " " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = { fg = "#f38ba8" }, -- Catppuccin Red
            },
            {
              -- Visual 模式选中行数/字数统计
              function()
                local starts = vim.fn.line("v")
                local ends = vim.fn.line(".")
                local count = starts <= ends and ends - starts + 1 or starts - ends + 1
                return "󰒰 " .. count .. " Lines"
              end,
              cond = function()
                local mode = vim.fn.mode()
                return mode == "v" or mode == "V" or mode == "\22" -- \22 对应 Ctrl-V
              end,
              color = { fg = "#cba6f7", gui = "bold" },
            },
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = { fg = "#fab387" },
            },
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = { fg = "#fab387" },
            },
            {
              function() return require("noice").api.status.search.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.search.has() end,
              color = { fg = "#fab387" },
            },
            {
              -- 精简版的 LSP 客户端显示
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                local names = {}
                for _, client in ipairs(clients) do
                  -- 排除名字太长的某些辅助服务
                  if client.name ~= "copilot" and client.name ~= "null-ls" then
                    table.insert(names, client.name)
                  end
                end
                if #names == 0 then return "" end
                return "  " .. table.concat(names, ", ")
              end,
              cond = function() return #vim.lsp.get_clients({ bufnr = 0 }) > 0 end,
            },
            {
              "copilot",
              show_colors = true,
              symbols = {
                status = {
                  icons = {
                    enabled = " ",
                    sleep = " ",
                    disabled = " ",
                    warning = " ",
                    unknown = " "
                  },
                  hl = {
                    enabled = "#A6E3A1",
                    sleep = "#AEB6FF",
                    disabled = "#626880",
                    warning = "#F38BA8",
                    unknown = "#F38BA8"
                  }
                },
              },
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
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
            { "encoding" },
            { "fileformat" },
            { "progress", padding = { left = 1, right = 1 } },
          },
          lualine_z = {
            { "location", separator = " ", padding = { left = 1, right = 0 } },
            { function() return " " .. os.date("%H:%M") end, padding = { left = 1, right = 1 } },
          },
        },
        extensions = { "neo-tree", "lazy", "toggleterm", "trouble" },
      }
    end,
  },

  -- Bufferline (tab bar)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Left" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Right" },
    },
    opts = function()
      local opts = {
        options = {
          close_command = function(n) require("mini.bufremove").delete(n, false) end,
          right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      }

      local has_catppuccin, catppuccin_bufferline = pcall(require, "catppuccin.groups.integrations.bufferline")
      if has_catppuccin then
        opts.highlights = catppuccin_bufferline.get()
      end

      return opts
    end,
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

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    main = "ibl",
    opts = {
      indent = { char = "│", tab_char = "│" },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help", "alpha", "dashboard", "neo-tree", "Trouble",
          "trouble", "lazy", "mason", "notify", "toggleterm", "lazyterm",
        },
      },
    },
  },

  -- Active indent guide and target indent scope
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help", "alpha", "dashboard", "neo-tree", "Trouble",
          "trouble", "lazy", "mason", "notify", "toggleterm", "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Noice (better cmd/msg/notify UI)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
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
        inc_rename = true,
      },
    },
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = { "i", "n", "s" } },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = { "i", "n", "s" } },
    },
  },

  -- Notification manager
  {
    "rcarriga/nvim-notify",
    keys = {
      { "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss All Notifications" },
    },
    opts = {
      stages = "static",
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
      on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 100 }) end,
    },
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local logo = [[
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = { statusline = false },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            { action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
            { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
            { action = "Telescope oldfiles", desc = " Recent Files", icon = " ", key = "r" },
            { action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
            { action = "e $MYVIMRC", desc = " Config", icon = " ", key = "c" },
            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- Open dashboard after closing lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "Tabs", icon = "󰓩 " },
          { "<leader>b", group = "Buffer", icon = "󰓩 " },
          { "<leader>c", group = "Code/LSP", icon = " " },
          { "<leader>d", group = "Debug (DAP)", icon = " " },
          { "<leader>dP", group = "Python Debug", icon = " " },
          { "<leader>f", group = "File/Find", icon = " " },
          { "<leader>g", group = "Git", icon = " " },
          { "<leader>gh", group = "Hunks", icon = " " },
          { "<leader>l", group = "Lazy/Plugin", icon = "󰒲 " },
          { "<leader>p", group = "AI/Copilot", icon = " " },
          { "<leader>q", group = "Quit/Session", icon = "󰗼 " },
          { "<leader>s", group = "Search", icon = "󰜋 " },
          { "<leader>sn", group = "Noice", icon = "󰎟 " },
          { "<leader>t", group = "Terminal", icon = " " },
          { "<leader>u", group = "UI/Toggles", icon = "󰙵 " },
          { "<leader>w", group = "Windows", icon = " " },
          { "<leader>x", group = "Diagnostics", icon = "󱖫 " },
          { "[", group = "Prev", icon = " " },
          { "]", group = "Next", icon = " " },
          { "g", group = "Goto", icon = " " },
          { "gs", group = "Surround", icon = "󰑃 " },
          { "z", group = "Fold", icon = " " },
        },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)" },
    },
  },

  -- Mini.bufremove
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
}

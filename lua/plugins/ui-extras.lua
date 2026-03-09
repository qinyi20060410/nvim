return {
  -- 1. 代码缩进线 (Indent Blankline v3)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "TelescopePrompt",
          "TelescopeResults",
        },
      },
    },
  },

  -- 2. 彩色括号对齐 (Rainbow Delimiters)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      -- 利用原生的 treesitter 精准解析实现括号彩虹色
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        -- 这里的颜色组已经和 Catppuccin 主题完美贴合
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- 3. 丝滑的光标残影拖尾动画 (Smear Cursor)
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      -- 光标残影透明度和动画时间控制（默认值表现已经非常优秀）
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
      hide_target_hack = false,
      -- 如果想禁用某些特定文件类型可以加在此处
      filetypes_disabled = {
        "neo-tree",
        "lazy",
        "mason",
        "copilot-chat",
      },
    },
  },

  -- 4. 右侧全局高级滚动条显示 (Satellite)
  {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {
      current_only = false,
      winblend = 50,
      zindex = 40,
      handlers = {
        cursor = { enable = true },      -- 显示当前光标区域
        search = { enable = true },      -- 显示搜索高亮词在哪
        diagnostic = { enable = true },  -- 右侧滚动条标红/黄点提示 LSP 错误
        gitsigns = { enable = true },    -- 在滚动条标记代码修改处
        marks = { enable = true },       -- 显示书签
        quickfix = { enable = true },
      },
    },
  },
}
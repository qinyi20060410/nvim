return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- 核心功能：幽灵文本（内联建议）
        suggestion = {
          enabled = true,
          auto_trigger = true, -- 输入时自动触发
          debounce = 75,
          keymap = {
            accept = "<M-l>",      -- Alt + l 接受建议
            accept_word = "<M-w>", -- Alt + w 接受一个词
            accept_line = false,
            next = "<M-]>",        -- Alt + ] 下一个建议
            prev = "<M-[>",        -- Alt + [ 上一个建议
            dismiss = "<C-]>",     -- 取消建议
          },
        },
        -- 右侧大面板建议（可选开启，这里默认关闭避免干扰）
        panel = {
          enabled = false,
        },
        filetypes = {
          yaml = false,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      })
    end,
  },
  
  -- Copilot Chat 侧边栏及交互（强烈推荐的扩展插件）
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- 必须依赖 plenary
    },
    build = "make tiktoken", -- 仅适用于 macOS/Linux
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatStop",
      "CopilotChatReset",
      "CopilotChatSave",
      "CopilotChatLoad",
      "CopilotChatDebugInfo",
      "CopilotChatModels",
      "CopilotChatAgents",
    },
    opts = {
      show_help = "yes", -- 默认显示帮助
      window = {
        layout = "float", -- 可以改成 'vertical' 在右侧打开，而 float 是浮窗
        width = 0.8,
        height = 0.8,
      },
    },
    keys = {
      { "<leader>pc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat" },
      { "<leader>pe", "<cmd>CopilotChatExplain<cr>", desc = "Copilot Explain" },
      { "<leader>pr", "<cmd>CopilotChatReview<cr>", desc = "Copilot Review" },
      { "<leader>pf", "<cmd>CopilotChatFix<cr>", desc = "Copilot Fix" },
      { "<leader>po", "<cmd>CopilotChatOptimize<cr>", desc = "Copilot Optimize" },
      { "<leader>pd", "<cmd>CopilotChatDocs<cr>", desc = "Copilot Docs" },
      { "<leader>pt", "<cmd>CopilotChatTests<cr>", desc = "Copilot Tests" },
      { "<leader>pm", "<cmd>CopilotChatCommit<cr>", desc = "Copilot Message (Commit)" },
    },
  },
}
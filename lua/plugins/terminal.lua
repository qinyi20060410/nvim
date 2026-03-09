-- ╭──────────────────────────────────────────────────────────╮
-- │                  Terminal Integration                     │
-- ╰──────────────────────────────────────────────────────────╯

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "rounded",
        winblend = 0,
      },
      winbar = {
        enabled = false,
      },
    },
    keys = {
      { "<c-\\>", desc = "Toggle Terminal (Float)" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (Float)" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal (Horizontal)" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal (Vertical)" },
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Better terminal navigation
      function _G.set_terminal_keymaps()
        local term_opts = { buffer = 0, noremap = true }
        vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], term_opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], term_opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], term_opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], term_opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], term_opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], term_opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                    Neovim Configuration                  │
-- │            Inspired by LazyVim, standalone setup         │
-- ╰──────────────────────────────────────────────────────────╯

-- Load core config
require("config.options")
require("config.lazy")

-- These are loaded after lazy.nvim startup via autocmd
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.autocmds")
    require("config.keymaps")
  end,
})

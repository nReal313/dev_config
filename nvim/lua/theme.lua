-- =========================================
-- Theme
-- =========================================
require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    telescope = true,
    nvimtree = true,
    gitsigns = true,
    treesitter = true,
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin")



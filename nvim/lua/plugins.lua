
-- =========================================
-- Plugins
-- =========================================
require("lazy").setup({
  -- theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- search / picker
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- syntax
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

      -- smooth scrolling
  {
    "karb94/neoscroll.nvim",
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
  },

  -- autopairs
  {
    "echasnovski/mini.pairs",
    version = false,
  },

  -- formatter
  {
    "stevearc/conform.nvim",
  },

  -- LSP + tooling
  {
    "mason-org/mason.nvim",
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  }, 


  -- java support
  {
  "mfussenegger/nvim-jdtls",
  },


  -- completion
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = { preset = "default" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        menu = {
          auto_show = true,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
  },
})

-- =========================================
-- Plugin setup
-- =========================================
require("mini.pairs").setup()

require("gitsigns").setup()

require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    section_separators = "",
    component_separators = "",
  },
})

require("nvim-tree").setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 34,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
})


require("neoscroll").setup({
  mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
  hide_cursor = true,
  stop_eof = true,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
})

require("telescope").setup({
  defaults = {
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    winblend = 0,
  },
})

require("nvim-treesitter.configs").setup({
    ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "bash",
    "markdown",
    "markdown_inline",
    "json",
    "yaml",
    "go",
    "python",
    "javascript",
    "typescript",
    "java",
    "tsx",
  },
  highlight = { enable = true },
  indent = { enable = true },
})

require("mason").setup()

require("conform").setup({
  format_on_save = nil,
    formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "gofmt", "goimports" },
    python = { "ruff_format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    java = { "google-java-format" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    tsx = { "prettier" },
  },
})



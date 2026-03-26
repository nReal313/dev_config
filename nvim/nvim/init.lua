vim.g.mapleader = " "

-- =========================================
-- Basic options
-- =========================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- =========================================
-- Bootstrap lazy.nvim
-- =========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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

  -- keymap helper
  {
    "folke/which-key.nvim",
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

-- =========================================
-- Plugin setup
-- =========================================
require("mini.pairs").setup()

require("which-key").setup({})

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

-- =========================================
-- LSP
-- =========================================
local capabilities = require("blink.cmp").get_lsp_capabilities()

local lspconfig = require("lspconfig")

local servers = {
  "lua_ls",
  "clangd",
  "gopls",
  "pyright",
  "ts_ls",
}

for _, server in ipairs(servers) do
  if server ~= "lua_ls" then
    lspconfig[server].setup({
      capabilities = capabilities,
    })
  end
end

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

-- Java: start jdtls only for Java buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local jdtls = require("jdtls")
    local root_dir = require("jdtls.setup").find_root({
      "gradlew",
      "mvnw",
      ".git",
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
    })

    if not root_dir then
      return
    end

    local project_name = vim.fn.fnamemodify(root_dir, ":p:t")
    local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

    local config = {
      cmd = {
        "jdtls",
        "-data",
        workspace_dir,
      },
      root_dir = root_dir,
      capabilities = capabilities,
    }

    jdtls.start_or_attach(config)
  end,
})



-- =========================================
-- Keymaps
-- =========================================
local map = vim.keymap.set

-- tree
map("n", "<leader>e", "<cmd>NvimTreeFindFile<CR>", { desc = "Focus tree / reveal file" })
map("n", "<leader>E", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle tree" })

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- file ops
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit" })

-- manual format only
map("n", "<leader>fm", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format file" })

-- terminal
map("n", "<leader>tt", "<cmd>belowright split | terminal<CR>", { desc = "Open terminal" })
map("t", "<Esc>", [[<C-\><C-n>]])
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- split navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- buffer nav
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })

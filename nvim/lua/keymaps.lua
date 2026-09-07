-- =========================================
-- Keymaps
-- =========================================
local map = vim.keymap.set

-- macOS terminals send Option+Delete as Meta+Backspace.
map("i", "<M-BS>", "<C-w>", { desc = "Delete previous word" })

map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>h", ":nohlsearch<CR>", { silent = true })

-- yazi
map("n", "<leader>e", "<cmd>Yazi<CR>", { desc = "Open Yazi" })
map("n", "<leader>E", "<cmd>Yazi cwd<CR>", { desc = "Open Yazi in cwd" })


-- git
map("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview Git hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset Git hunk" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage Git hunk" })
map("n", "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle Git line blame" })
map("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Show Git line blame" })

local function git_revision_file(command, prompt)
  vim.ui.input({ prompt = prompt }, function(revision)
    if not revision or revision == "" then
      return
    end

    vim.api.nvim_cmd({ cmd = command, args = { revision .. ":%" } }, {})
  end)
end

map("n", "<leader>gD", function()
  git_revision_file("Gvdiffsplit", "Diff current file against revision: ")
end, { desc = "Diff current file against Git revision" })

map("n", "<leader>gE", function()
  git_revision_file("Gedit", "Open current file from revision: ")
end, { desc = "Open current file from Git revision" })


-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })

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
map("t", "<C-]>", [[<C-\><C-n>]])
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- buffer nav
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- structural navigation
local function jump_to_enclosing_type()
  local node = vim.treesitter.get_node()
  if not node then
    vim.notify("No syntax node under the cursor", vim.log.levels.WARN)
    return
  end

  local type_nodes = {
    -- Python / JavaScript / TypeScript
    class_definition = true,
    class_declaration = true,
    class = true,
    interface_declaration = true,
    type_alias_declaration = true,

    -- C / C++ / C# / Java
    class_specifier = true,
    struct_specifier = true,
    union_specifier = true,
    enum_specifier = true,
    struct_declaration = true,
    enum_declaration = true,
    record_declaration = true,
    annotation_type_declaration = true,

    -- Rust
    impl_item = true,
    struct_item = true,
    enum_item = true,
    trait_item = true,

    -- Kotlin / PHP / Ruby and similar parsers
    object_declaration = true,
    trait_declaration = true,
    module = true,
  }

  while node do
    if type_nodes[node:type()] then
      local row, col = node:start()
      vim.cmd("normal! m'")
      vim.api.nvim_win_set_cursor(0, { row + 1, col })
      vim.cmd("normal! zz")
      return
    end
    node = node:parent()
  end

  vim.notify("No enclosing class/type found", vim.log.levels.INFO)
end

map("n", "gC", jump_to_enclosing_type, { desc = "Jump to enclosing type" })

-- diagnostics
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })

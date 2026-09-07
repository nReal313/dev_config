return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewRefresh",
		"DiffviewFileHistory",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open Git diff" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Current file Git history" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Repository Git history" },
		{ "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Close Git diff" },
	},
	opts = {},
}

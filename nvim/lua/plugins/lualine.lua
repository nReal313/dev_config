return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			theme = "auto",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					function()
						return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
					end,
					icon = "",
				},
			},
			lualine_c = { "filename" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}

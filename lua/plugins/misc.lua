return {
	{
		"folke/which-key.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			--configuration
			--if empty, use default settings
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{ "echasnovski/mini.icons", version = false },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"shahshlok/vim-coach.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		config = function()
			require("vim-coach").setup()
		end,
		keys = {
			{ "<leader>?", "<cmd>VimCoach<cr>", desc = "Vim Coach" },
		},
	},
	{
		"tris203/precognition.nvim",
		--event = "VeryLazy",
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
	},
}

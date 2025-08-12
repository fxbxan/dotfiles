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
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
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

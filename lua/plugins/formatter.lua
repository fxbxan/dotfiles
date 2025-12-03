return {
	{
		"stevearc/conform.nvim",
		opts = {
			log_level = vim.log.levels.INFO,

			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettier" },
				vue = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_format = "first",
			},

			formatters = {
				prettier = {
					cwd = function()
						return require("conform.util").root_file({
							".prettierrc",
							".prettierrc.json",
							".prettierrc.yml",
							".prettierrc.yaml",
							".prettierrc.json5",
							".prettierrc.js",
							".prettier.config.js",
							".prettier.config.cjs",
							".prettier.config.mjs",
							"package.json",
						})
					end,
					prepend_args = { "--config-precedence", "prefer-file" },
				},
			},
		},
	},
}


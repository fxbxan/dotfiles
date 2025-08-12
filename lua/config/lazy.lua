-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
		{ import = "plugins.lsp" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

require("conform").setup({
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
			cwd = require("conform.util").root_file({
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
			}),
			prepend_args = { "--config-precedence", "prefer-file" },
		},
	},
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- Default configuration
require("tiny-inline-diagnostic").setup({
	-- Style preset for diagnostic messages
	-- Available options:
	-- "modern", "classic", "minimal", "powerline",
	-- "ghost", "simple", "nonerdfont", "amongus"
	preset = "minimal",

	transparent_bg = false, -- Set the background of the diagnostic to transparent
	transparent_cursorline = false, -- Set the background of the cursorline to transparent (only one the first diagnostic)

	hi = {
		error = "DiagnosticError", -- Highlight group for error messages
		warn = "DiagnosticWarn", -- Highlight group for warning messages
		info = "DiagnosticInfo", -- Highlight group for informational messages
		hint = "DiagnosticHint", -- Highlight group for hint or suggestion messages
		arrow = "NonText", -- Highlight group for diagnostic arrows

		-- Background color for diagnostics
		-- Can be a highlight group or a hexadecimal color (#RRGGBB)
		background = "CursorLine",

		-- Color blending option for the diagnostic background
		-- Use "None" or a hexadecimal color (#RRGGBB) to blend with another color
		mixing_color = "None",
	},

	options = {
		-- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
		show_source = {
			enabled = false,
			if_many = false,
		},

		-- Use icons defined in the diagnostic configuration
		use_icons_from_diagnostic = false,

		-- Set the arrow icon to the same color as the first diagnostic severity
		set_arrow_to_diag_color = false,

		-- Add messages to diagnostics when multiline diagnostics are enabled
		-- If set to false, only signs will be displayed
		add_messages = true,

		-- Time (in milliseconds) to throttle updates while moving the cursor
		-- Increase this value for better performance if your computer is slow
		-- or set to 0 for immediate updates and better visual
		throttle = 20,

		-- Minimum message length before wrapping to a new line
		softwrap = 30,

		-- Configuration for multiline diagnostics
		-- Can either be a boolean or a table with the following options:
		--  multilines = {
		--      enabled = false,
		--      always_show = false,
		-- }
		-- If it set as true, it will enable the feature with this options:
		--  multilines = {
		--      enabled = true,
		--      always_show = false,
		-- }
		multilines = {
			-- Enable multiline diagnostic messages
			enabled = true,

			-- Always show messages on all lines for multiline diagnostics
			always_show = false,

			-- Trim whitespaces from the start/end of each line
			trim_whitespaces = false,

			-- Replace tabs with spaces in multiline diagnostics
			tabstop = 4,
		},

		-- Display all diagnostic messages on the cursor line
		show_all_diags_on_cursorline = false,

		-- Enable diagnostics in Insert mode
		-- If enabled, it is better to set the `throttle` option to 0 to avoid visual artifacts
		enable_on_insert = false,

		-- Enable diagnostics in Select mode (e.g when auto inserting with Blink)
		enable_on_select = false,

		overflow = {
			-- Manage how diagnostic messages handle overflow
			-- Options:
			-- "wrap" - Split long messages into multiple lines
			-- "none" - Do not truncate messages
			-- "oneline" - Keep the message on a single line, even if it's long
			mode = "wrap",

			-- Trigger wrapping to occur this many characters earlier when mode == "wrap".
			-- Increase this value appropriately if you notice that the last few characters
			-- of wrapped diagnostics are sometimes obscured.
			padding = 0,
		},

		-- Configuration for breaking long messages into separate lines
		break_line = {
			-- Enable the feature to break messages after a specific length
			enabled = false,

			-- Number of characters after which to break the line
			after = 30,
		},

		-- Custom format function for diagnostic messages
		-- Example:
		-- format = function(diagnostic)
		--     return diagnostic.message .. " [" .. diagnostic.source .. "]"
		-- end
		format = nil,

		virt_texts = {
			-- Priority for virtual text display
			priority = 2048,
		},

		-- Filter diagnostics by severity
		-- Available severities:
		-- vim.diagnostic.severity.ERROR
		-- vim.diagnostic.severity.WARN
		-- vim.diagnostic.severity.INFO
		-- vim.diagnostic.severity.HINT
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},

		-- Events to attach diagnostics to buffers
		-- You should not change this unless the plugin does not work with your configuration
		overwrite_events = nil,
	},
	disabled_ft = {}, -- List of filetypes to disable the plugin
})

return {
	{
		"rebelot/kanagawa.nvim",
		opts = {
			compile = true, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = false },
			functionStyle = {},
			keywordStyle = { italic = false },
			statementStyle = { bold = true },
			theme = "wave", -- Load "wave" theme
			background = { -- map the value of 'background' option to a theme
				dark = "dragon", -- try "dragon" !
				light = "lotus",
			},
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "kanagawa-dragon",
		},
	},
}

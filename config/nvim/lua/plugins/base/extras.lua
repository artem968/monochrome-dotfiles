return {
    -- Surround
    {
        "kylechui/nvim-surround",
        version = "*", -- use latest stable
        event = "VeryLazy", -- load lazily
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                notify = false,
                plugins = {
                    spelling = true, -- optional
                },
            })
        end,
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter", -- only load when entering insert mode
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,  -- integrates with treesitter
                enable_check_bracket_line = true,
            })
        end,
    },
}

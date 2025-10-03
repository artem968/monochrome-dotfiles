return {
    {
        "goolord/alpha-nvim",
        dependencies = {
            "echasnovski/mini.icons",
            "nvim-lua/plenary.nvim"
        },
        lazy = false,
        config = function()
            require("core.alpha").setup()  -- ✅ call setup
        end
    }
}

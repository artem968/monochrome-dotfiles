return {

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            local ok, lualine = pcall(require, "lualine")
            if not ok then
                vim.notify("Lualine not found!", vim.log.levels.ERROR)
                return
            end
    
            lualine.setup({
                options = {
                    theme = "auto", -- integrate with black-metal
                    icons_enabled = true,
                    section_separators = { left = "", right = "" }, -- fat arrows
                    component_separators = { left = "", right = "" }, -- thin arrows
                    disabled_filetypes = {},
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff" },
                    lualine_c = { "filename" },
                    lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
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
                extensions = { "nvim-tree", "quickfix" },
            })
    
            -- Override highlights for monochrome look
            vim.cmd([[
                " mode sections (lualine_a)
                highlight! LualineA_normal guibg=#111111 guifg=#bbbbbb
                highlight! LualineA_insert guibg=#111111 guifg=#bbbbbb
                highlight! LualineA_visual guibg=#111111 guifg=#bbbbbb
                highlight! LualineA_replace guibg=#111111 guifg=#bbbbbb
    
                " surrounding sections
                highlight! LualineB_normal guibg=#1a1a1a guifg=#aaaaaa
                highlight! LualineC_normal guibg=#222222 guifg=#999999
                highlight! LualineX_normal guibg=#222222 guifg=#999999
                highlight! LualineY_normal guibg=#1a1a1a guifg=#aaaaaa
                highlight! LualineZ_normal guibg=#111111 guifg=#bbbbbb
    
                " separators (make sure they blend in)
                highlight! StatusLine guibg=#000000 guifg=#888888
                highlight! StatusLineNC guibg=#000000 guifg=#444444
            ]])
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require("nvim-tree").setup({
                sort_by = "name",
                view = { width = 30, side = "left" },
                renderer = {
                    highlight_git = true,
                    icons = {
                        show = { file = true, folder = true, folder_arrow = true, git = true },
                        webdev_colors = false,
                    },
                },
                filters = { dotfiles = false },
            })
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
    
            -- Highlight overrides for Marduk monochrome
            vim.cmd([[
              highlight NvimTreeGitDirty    guifg=#888888
              highlight NvimTreeGitNew      guifg=#888888
              highlight NvimTreeGitRenamed  guifg=#888888
              highlight NvimTreeGitDeleted  guifg=#888888
              highlight NvimTreeFolderIcon  guifg=#bbbbbb
              highlight NvimTreeFolderName  guifg=#bbbbbb
            ]])
        end
    },

    -- Bufferline (tabs / open files)
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        lazy = false,
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    middle_mouse_command = nil,
                    diagnostics = "nvim_lsp",
                    separator_style = "slant",
                    show_buffer_close_icons = true,
                    show_close_icon = false,
                    enforce_regular_tabs = true,
                },
            })

            -- Navigate buffers
            vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
            vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local highlight_color = "#333333" -- subtle grey bar
    
            require("ibl").setup({
                indent = {
                    char = "│",         -- vertical bar
                    highlight = "IblIndent",
                },
                scope = {
                    enabled = false,    -- disable current scope highlight for cleaner look
                },
            })
    
            -- Define monochrome highlight for indent guides
            vim.cmd(string.format("highlight IblIndent guifg=%s gui=nocombine", highlight_color))
        end,
    },
}

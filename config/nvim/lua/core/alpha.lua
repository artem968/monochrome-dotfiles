-- Core Alpha configuration
local M = {}

function M.setup()
    local ok, alpha = pcall(require, "alpha")
    if not ok then return end

    local dashboard = require("alpha.themes.dashboard")

    -- Header
    dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
    }

    -- Buttons
    dashboard.section.buttons.val = {
        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", " > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
        dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        dashboard.button("q", "󰈆 > Quit NVIM", ":qa<CR>"),
    }

    -- Center layout
    dashboard.config.layout = {
        { type = "padding", val = math.floor((vim.o.lines - #dashboard.section.header.val - #dashboard.section.buttons.val - 2) / 2) },
        dashboard.section.header,
        { type = "padding", val = 1 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
    }

    -- Remove tilde lines (~)
    vim.opt.fillchars:append("eob: ")

    -- Setup alpha
    alpha.setup(dashboard.opts)

    -- Disable folding
    vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])

    -- Auto-start Alpha on empty buffers
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            if vim.fn.argc() == 0 then
                require("alpha").start(true)
            end
        end,
    })
end

return M

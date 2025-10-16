-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
    spec = {
        -- Core base plugins (UI, LSP, tools)
        { import = "plugins.base" },
        { import = "plugins.base.debug" },

        -- Extra plugins (optional, including alpha)
        { import = "plugins.extra" },
    },

    defaults = {
        lazy = true,      -- load plugins lazily by default
        version = false,  -- always use latest git version
    },

    install = { colorscheme = { "black-metal" } },

    checker = { enabled = true },  -- automatically check for plugin updates
})

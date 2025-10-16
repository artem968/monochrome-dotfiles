-- ~/.config/nvim/lua/plugins/base/debug/dap.lua
return {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = { "folke/which-key.nvim" },
    config = function()
        vim.g.which_key_disable_warn = 1
        local dap = require("dap")

        -- === Helper: find project root by locating nearest .csproj ===
        local function find_project_root()
            local dir = vim.fn.expand("%:p:h")
            while dir ~= "/" do
                if vim.fn.globpath(dir, "*.csproj") ~= "" then
                    return dir
                end
                dir = vim.fn.fnamemodify(dir, ":h")
            end
            return vim.fn.getcwd()
        end

        -- === Adapter ===
        dap.adapters.coreclr = {
            type = "executable",
            command = "/sbin/netcoredbg", -- replace with your netcoredbg path
            args = { "--interpreter=vscode" },
        }

        -- === Configuration ===
        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "Launch - NetCoreDbg",
                request = "launch",
                program = function()
                    local root = find_project_root()
                
                    -- Build the project
                    local build_cmd = "dotnet build " .. root
                    vim.fn.system(build_cmd)
                
                    -- Look for the compiled DLL (first found)
                    local dll = vim.fn.glob(root .. "/bin/Debug/**/*.dll")
                    if dll == "" then
                        -- fallback: ask user for path
                        return vim.fn.input("Path to DLL: ", root .. "/bin/Debug/", "file")
                    end
                    return dll
                end,
            },
        }

        -- === Keymaps for actual use ===
        local map = vim.keymap.set
        map("n", "<leader>dd", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debug Continue" })
        map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
        map("n", "<leader>dn", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Step Over" })
        map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Step Into" })
        map("n", "<leader>do", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Step Out" })
        map("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", { desc = "Open REPL" })
        map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Run Last" })

        -- === Which-key registration (v2 flat style, no warnings) ===
        local wk_ok, wk = pcall(require, "which-key")
        if wk_ok then
            wk.register({
                { "<leader>d", group = "Debug" },
                { "<leader>db", desc = "Toggle Breakpoint" },
                { "<leader>dd", desc = "Debug Continue" },
                { "<leader>di", desc = "Step Into" },
                { "<leader>dl", desc = "Run Last" },
                { "<leader>dn", desc = "Step Over" },
                { "<leader>do", desc = "Step Out" },
                { "<leader>dr", desc = "Open REPL" },
            }, { mode = "n" })
        end
    end,
}

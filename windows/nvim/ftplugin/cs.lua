vim.treesitter.start()

vim.cmd("compiler dotnet")

local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
end

map("<leader>db", "<cmd>Make<cr>", "C#: build solution")
map("<leader>dt", "<cmd>Dispatch dotnet test<cr>", "C#: run tests")
map("<leader>dr", "<cmd>Dispatch dotnet run<cr>", "C#: run project")

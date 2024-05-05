vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after') 
vim.o.packpath = vim.o.runtimepath 
vim.cmd('source ~/.vimrc')

require('lean').setup({
  lsp = { on_attach = on_attach },
  mappings = true,
})

require("nvim-lightbulb").setup({
  autocmd = { enabled = true }
})

require("goto-preview").setup({})


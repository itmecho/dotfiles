vim.cmd [[ command! ItmechoInstallLsps :lua require('itmecho.utils').install_lsp_servers() ]]

vim.cmd [[ command! Notes :lua require('itmecho.notes').list() ]]
vim.cmd [[ command! NotesNew :lua require('itmecho.notes').create() ]]

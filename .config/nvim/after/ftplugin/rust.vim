set textwidth=80
set colorcolumn=80

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{aligned = true}

nnoremap <buffer> <leader>ca :!cargo add<Space>
nnoremap <buffer> <leader>cc :call RnrExec("cargo clippy")<CR>
nnoremap <buffer> <leader>ct :call RnrExec("cargo test")<CR>
nnoremap <buffer> <leader>cr :call RnrExec("cargo run")<CR>

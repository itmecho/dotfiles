nnoremap <buffer> <leader>ca :!cargo add<Space>
nnoremap <buffer> <leader>cc :call RnrExec("cargo clippy")<CR>
nnoremap <buffer> <leader>ct :call RnrExec("cargo test")<CR>
nnoremap <buffer> <leader>cr :call RnrExec("cargo run")<CR>

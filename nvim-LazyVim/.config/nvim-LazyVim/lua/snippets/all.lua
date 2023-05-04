return {
  s('uuidgen', f(function()
    return vim.fn.trim(vim.fn.system('uuidgen'))
  end))
}

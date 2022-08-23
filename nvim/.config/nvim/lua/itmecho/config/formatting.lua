local function stdin_fmt(config)
  config = vim.tbl_deep_extend('force', config, { stdin = true })
  return {
    function()
      return config
    end,
  }
end

local function prettier(parser)
  local exe = ''
  if vim.fn.exists('./node_modules/.bin/prettier') then
    exe = './node_modules/.bin/prettier'
  end

  return stdin_fmt({
    exe = exe,
    args = {
      '--parser=' .. parser,
      '--stdin-filename',
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
    },
  })
end

require('formatter').setup({
  silence_missing_config = true,
  filetype = {
    typescript = prettier('typescript'),
    typescriptreact = prettier('typescript'),
    svelte = stdin_fmt({
      exe = './node_modules/.bin/prettier',
      args = {
        '--parser=svelte',
        '--stdin-filename',
        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      },
    }),
    lua = stdin_fmt({
      exe = 'stylua',
      args = { '--search-parent-directories', '-' },
    }),
    rust = stdin_fmt({
      exe = 'rustfmt',
      args = { '--emit=stdout' },
    }),
    go = {
      function()
        -- if string.match(vim.loop.cwd(), "CloudExperiments") then
        -- 	return {
        -- 		exe = "goimports",
        -- 		stdin = true,
        -- 	}
        -- end
        return {
          exe = 'golines',
          args = { '-m', '120', '--base-formatter', 'goimports' },
          stdin = true,
        }
      end,
    },
    python = stdin_fmt({
      exe = 'black',
      args = { '-' },
    }),
    terraform = stdin_fmt({
      exe = 'terraform',
      args = { 'fmt', '-' },
    }),
    proto = stdin_fmt({
      exe = 'clang-format',
      args = {
        '--assume-filename=file.proto',
        '--style=Google',
      },
    }),
  },
})

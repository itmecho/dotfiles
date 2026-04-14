vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-telescope/telescope.nvim',
})

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set(
  'n',
  '<leader>fp',
  string.format('<cmd>Telescope find_files find_command=fd,--type,f,.proto$ cwd=%s<cr>', os.getenv('CLOUDPATH'))
)
vim.keymap.set(
  'n',
  '<leader>fk',
  string.format('<cmd>Telescope find_files find_command=fd,--type,f cwd=%s<cr>', os.getenv('CLOUDPATH') .. '/kustomize')
)
vim.keymap.set(
  'n',
  '<leader>fc',
  string.format('<cmd>Telescope find_files find_command=fd,--type,f cwd=%s/.config/nvim<cr>', os.getenv('HOME'))
)
vim.keymap.set('n', '<leader>sw', 'yiw:Telescope grep_string search=<c-r>"<cr>')
vim.keymap.set('v', '<leader>sw', 'y:Telescope grep_string search=<c-r>"<cr>')
vim.keymap.set('n', '<leader>sg', function()
  local opts = { cwd = vim.uv.cwd() }
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local make_entry = require('telescope.make_entry')
  local conf = require('telescope.config').values

  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or #prompt < 2 then
        return nil
      end

      local pieces = vim.split(prompt, '  ')
      local args = { 'rg' }
      if pieces[1] then
        table.insert(args, '-e')
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, '-g')
        table.insert(args, pieces[2])
      end

      return vim
        .iter({
          args,
          { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Multi Grep',
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end)

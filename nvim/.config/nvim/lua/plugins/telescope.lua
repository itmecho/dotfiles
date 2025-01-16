return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'folke/trouble.nvim',
  },
  lazy = false,
  keys = {
    -- Find
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'List buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'List helptags' },
    {
      '<leader>fp',
      string.format('<cmd>Telescope find_files find_command=fd,--type,f,.proto$ cwd=%s<cr>', os.getenv('CLOUDPATH')),
      desc = 'List proto files',
    },
    {
      '<leader>fk',
      string.format(
        '<cmd>Telescope find_files find_command=fd,--type,f cwd=%s<cr>',
        os.getenv('CLOUDPATH') .. '/kustomize'
      ),
      desc = 'Find kustomize files',
    },
    {
      '<leader>fc',
      string.format('<cmd>Telescope find_files find_command=fd,--type,f cwd=%s/.config/nvim<cr>', os.getenv('HOME')),
      desc = 'Find kustomize files',
    },

    -- Search
    {
      '<leader>sg',
      function()
        local opts = { cwd = vim.uv.cwd() }
        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local make_entry = require('telescope.make_entry')
        local conf = require('telescope.config').values

        local finder = finders.new_async_job({
          command_generator = function(prompt)
            if not prompt or prompt == '' then
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

            ---@diagnostic disable-next-line: deprecated
            return vim.tbl_flatten({
              args,
              { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
            })
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
      end,
      desc = 'Live grep',
    },
    { '<leader>sw', 'yiw:Telescope grep_string search=<c-r>"<cr>', desc = 'Search for current word in files' },
    {
      '<leader>sw',
      'y:Telescope grep_string search=<c-r>"<cr>',
      mode = 'v',
      desc = 'Search for current selection in files',
    },
    {
      '<leader>sh',
      'y:Telescope help_tags search=<c-r>"<cr>',
      mode = 'v',
      desc = 'Search for current selection in help',
    },
  },
  config = function()
    local open_with_trouble = require('trouble.sources.telescope').open
    local ts = require('telescope')

    ts.setup({
      defaults = {
        mappings = {
          i = { ['<c-t>'] = open_with_trouble },
          n = { ['<c-t>'] = open_with_trouble },
        },
      },
    })
  end,
}

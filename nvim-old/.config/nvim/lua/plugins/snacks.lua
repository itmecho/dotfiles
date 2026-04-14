local progress = vim.defaulttable()
vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= 'table' then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ('[%3d%%] %s%s'):format(
            value.kind == 'end' and 100 or value.percentage or 100,
            value.title or '',
            value.message and (' **%s**'):format(value.message) or ''
          ),
          done = value.kind == 'end',
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    local complete = #progress[client.id] == 0
    vim.notify(table.concat(msg, '\n'), 'info', {
      id = 'lsp_progress',
      title = client.name,
      opts = function(notif)
        notif.icon = complete and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
      timeout = complete and 2000 or 50000,
    })
  end,
})

local dimmed = false

return {
  'folke/snacks.nvim',
  lazy = false,
  config = function()
    require('snacks').setup({
      dim = { enabled = true },
      gitbrowse = { enabled = true },
      indent = { enabled = true, animate = { enabled = false } },
      input = { enabled = true, win = { style = "input", relative='cursor' } },
      lazygit = { enabled = true, win = { width = 0, height = 0 } },
      picker = { enabled = true },
      -- notifier = { enabled = true },
      statuscolumn = { enabled = false },
    })
  end,
  keys = {
    {
      '<leader>d',
      function()
        if dimmed then
          dimmed = false
          require('snacks').dim.disable()
        else
          dimmed = true
          require('snacks').dim.enable()
        end
      end,
    },
    -- {
    --   '<leader>g',
    --   function()
    --     require('snacks').lazygit()
    --   end,
    -- },
    {
      '<leader>Gb',
      function()
        require('snacks').git.blame_line()
      end,
    },
    {
      '<leader>Go',
      function()
        require('snacks').gitbrowse()
      end,
      mode = { 'n', 'v' },
    },
  },
}

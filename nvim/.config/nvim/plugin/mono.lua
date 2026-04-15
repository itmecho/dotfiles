local mono = require('itmecho.plugins.mono')

mono.setup({
  root = function()
    return vim.trim(vim.fn.system('git rev-parse --show-toplevel'))
  end,
  get_options = function()
    local js_dirs = {}
    local go_dirs = {}

    local js_job = require('itmecho.util.cmd').job_lines({
      cmd = 'sh -c "cd $CLOUDPATH && fd package.json | xargs dirname"',
      callback = function(line)
        if line ~= '.' then
          table.insert(js_dirs, line)
        end
      end,
      skip_empty_lines = true,
    })
    local go_job = require('itmecho.util.cmd').job_lines({
      cmd = 'sh -c "cd $CLOUDPATH && fd BUILD.bazel | xargs -P 0 -n 50 rg go_binary -l | xargs dirname"',
      callback = function(line)
        if line ~= '.' then
          table.insert(go_dirs, line)
        end
      end,
      skip_empty_lines = true,
    })

    vim.fn.jobwait({ js_job, go_job })

    return vim.iter({ js_dirs, go_dirs }):flatten():totable()
  end,
  tabline = true,
})

vim.keymap.set('n', '<leader>po', mono.new)

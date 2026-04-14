local M = {}

local pr_template = [[
### Description :open_book:

### Deploy :rocket:

### Testing notes :test_tube:

]]

function M.current_branch()
  local status, output = pcall(vim.fn.system, 'git rev-parse --abbrev-ref HEAD')
  if not status then
    error('failed to get current branch')
  end
  return vim.trim(output)
end

function M.create_pr(opts)
  opts = vim.tbl_extend('keep', opts or {}, {
    open_in_browser = false,
    open_in_octo = false,
  })
  local open_pr = function()
    if opts.open_in_octo then
      vim.cmd([[Octo pr view]])
    end
    if opts.open_in_browser then
      vim.fn.system('gh pr view --web')
    end
  end
  require('octo.gh').run({
    args = { 'pr', 'view', '--json', 'number', '-q', '.number' },
    cb = function(out)
      if out ~= '' then
        open_pr()
      else
        local branch = M.current_branch()
        local issue = string.match(branch, '^(%a+-%d+).*')
        local default = ''
        if issue then
          default = vim.fn.toupper(issue) .. ': '
        end
        local title = vim.fn.input({ prompt = 'Title: ', default = default })
        if title == "" then
          error("Emtpy PR title")
          return
        end
        vim.fn.system('git push')
        require('octo.gh').pr.create({
          title = title,
          body = pr_template,
          label = 'team/sparx-learning',
          reviewer = 'supersparks/sparx-learning',
          assignee = 'itmecho',
          draft = true,
        })
				print('Waiting for 5 seconds')
        vim.fn.system('sleep 5')
        open_pr()
      end
    end,
  })
end

local function run_cmd(cmd)
  local err
  local out

  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if data[1] ~= '' then
        out = data[1]
      end
    end,
    on_stderr = function(_, data)
      if data[1] ~= '' then
        err = data[1]
      end
    end,
  })

  vim.fn.jobwait({ job_id })

  return out, err
end

local function make_github_url(repo, branch, path)
  return repo .. '/blob/' .. branch .. path
end

local function make_codeberg_url(repo, branch, path)
  return repo .. '/src/branch/' .. branch .. path
end

function M.open_file_in_remote()
  local ce = os.getenv('CLOUDPATH')
  if ce == nil then
    print("CLOUDPATH isn't set")
    return
  end

  local repo, err = run_cmd('git remote get-url origin')
  if err ~= nil then
    print('Failed to get remote url: ' .. err)
    return
  end
  if repo:sub(1, 4) == 'git@' then
    repo = repo:gsub(':', '/'):gsub('git@', 'https://'):gsub('.git$', '')
  end

  local branch
  branch, err = run_cmd('git symbolic-ref refs/remotes/origin/HEAD')
  if err ~= nil then
    print('Failed to get default branch: ' .. err)
    print('  Try running: git remote set-head origin --auto')
    return
  end
  branch = branch:gsub('refs/remotes/origin/', '')

  local repo_dir
  repo_dir, err = run_cmd('git rev-parse --show-toplevel')
  if err ~= nil then
    print('Failed to get repo directory')
    return
  end

  local path = vim.api.nvim_buf_get_name(0)
  path = string.gsub(path, repo_dir, '')

  local url
  if repo:find('github') ~= nil then
    url = make_github_url(repo, branch, path)
  elseif repo:find('codeberg') ~= nil then
    url = make_codeberg_url(repo, branch, path)
  else
    print('Unsupported git hosting service')
    return
  end

  print('opening ' .. url)
  vim.fn.system('open ' .. url)
end

return M

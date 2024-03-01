local M = {}

local function run_cmd(cmd)
  local err
  local out

  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if data[1] ~= "" then
        out = data[1]
      end
    end,
    on_stderr = function(_, data)
      if data[1] ~= "" then
        err = data[1]
      end
    end,
  })

  vim.fn.jobwait({job_id})

  return out, err
end

local function make_github_url(repo, branch, path)
  return repo..'/blob/'..branch..path
end

local function make_codeberg_url(repo, branch, path)
  return repo..'/src/branch/'..branch..path
end

function M.open_file_in_remote()
  local ce = os.getenv('CLOUDPATH')
  if ce == nil then
    print("CLOUDPATH isn't set")
    return
  end

  local repo, err = run_cmd('git remote get-url origin')
  if err ~= nil then
    print('Failed to get remote url: '..err)
    return
  end
  if repo:sub(1, 4) == "git@" then
    repo = repo:gsub(':', '/'):gsub('git@', 'https://'):gsub('.git$', '')
  end

  local branch
  branch, err = run_cmd('git symbolic-ref refs/remotes/origin/HEAD')
  if err ~= nil then
    print('Failed to get default branch: '..err)
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

  print('opening '..url)
  vim.fn.system('open '..url)
end

return M

-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/iain/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/iain/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/iain/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/iain/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/iain/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["cht.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/cht.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["dart-vim-plugin"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/dart-vim-plugin"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/diffview.nvim"
  },
  dracula = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/dracula"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/harpoon"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nq\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\20buftype_exclude\1\2\0\0\rterminal\1\0\1\tchar\6|\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  neogit = {
    config = { "\27LJ\2\nz\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\1\rdiffview\2\1\0\1 disable_commit_confirmation\2\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["neoterm.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/neoterm.nvim"
  },
  ["nord-vim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nord-vim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireã\4\1\0\t\0 \0;6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\a\0005\5\5\0009\6\4\1B\6\1\2=\6\6\5=\5\b\0045\5\v\0009\6\t\0009\6\n\6)\b¸ˇB\6\2\2=\6\f\0059\6\t\0009\6\n\6)\b\4\0B\6\2\2=\6\r\0059\6\t\0009\6\14\6B\6\1\2=\6\15\0059\6\t\0009\6\16\6B\6\1\2=\6\17\0059\6\t\0009\6\18\0065\b\19\0B\6\2\2=\6\20\5=\5\t\0049\5\21\0009\5\22\0054\a\6\0005\b\23\0>\b\1\a5\b\24\0>\b\2\a5\b\25\0>\b\3\a5\b\26\0>\b\4\a5\b\27\0>\b\5\aB\5\2\2=\5\22\0045\5\29\0003\6\28\0=\6\30\5=\5\31\4B\2\2\1K\0\1\0\fsnippet\vexpand\1\0\0\0\1\0\2\19keyword_length\3\5\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\1\0\1\tname\fluasnip\fsources\vconfig\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\15formatting\1\0\0\vformat\1\0\0\15cmp_format\nsetup\flspkind\bcmp\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\nF\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\ftimeout\3–\15\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nvim-notify"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nﬁ\3\0\0\6\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\r\0005\4\n\0005\5\v\0=\5\f\4=\4\14\0035\4\15\0005\5\16\0=\5\17\0045\5\18\0=\5\19\4=\4\20\3=\3\21\2B\0\2\1K\0\1\0\16textobjects\tswap\18swap_previous\1\0\1\bgsp\21@parameter.inner\14swap_next\1\0\1\bgsn\21@parameter.inner\1\0\1\venable\2\vselect\1\0\0\fkeymaps\1\0\3\aif\20@function.inner\aiP\21@parameter.inner\aaf\20@function.outer\1\0\2\14lookahead\2\venable\2\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\15dockerfile\tfish\ago\thtml\15javascript\blua\trust\ttoml\btsx\15typescript\tyaml\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15rust-tools\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/rust-tools.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n£\2\0\0\a\0\16\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\0025\3\v\0005\4\b\0005\5\n\0005\6\t\0=\6\6\5=\5\a\4=\4\f\3=\3\r\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\15\0B\0\2\1K\0\1\0\15fzy_native\19load_extension\fpickers\fbuffers\1\0\0\1\0\0\1\0\1\n<c-d>\18delete_buffer\1\0\1\18sort_lastused\2\rmappings\6i\1\0\0\1\0\1\n<C-q>\19send_to_qflist\1\0\2\17shorten_path\2\19color_devicons\2\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["vim-fish"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/vim-fish"
  },
  ["vim-mdx-js"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/vim-mdx-js"
  },
  ["vim-prettier"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/vim-prettier"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/iain/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireã\4\1\0\t\0 \0;6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\a\0005\5\5\0009\6\4\1B\6\1\2=\6\6\5=\5\b\0045\5\v\0009\6\t\0009\6\n\6)\b¸ˇB\6\2\2=\6\f\0059\6\t\0009\6\n\6)\b\4\0B\6\2\2=\6\r\0059\6\t\0009\6\14\6B\6\1\2=\6\15\0059\6\t\0009\6\16\6B\6\1\2=\6\17\0059\6\t\0009\6\18\0065\b\19\0B\6\2\2=\6\20\5=\5\t\0049\5\21\0009\5\22\0054\a\6\0005\b\23\0>\b\1\a5\b\24\0>\b\2\a5\b\25\0>\b\3\a5\b\26\0>\b\4\a5\b\27\0>\b\5\aB\5\2\2=\5\22\0045\5\29\0003\6\28\0=\6\30\5=\5\31\4B\2\2\1K\0\1\0\fsnippet\vexpand\1\0\0\0\1\0\2\19keyword_length\3\5\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\1\0\1\tname\fluasnip\fsources\vconfig\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\1\0\0\16scroll_docs\fmapping\15formatting\1\0\0\vformat\1\0\0\15cmp_format\nsetup\flspkind\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\ftimeout\3–\15\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n£\2\0\0\a\0\16\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\0025\3\v\0005\4\b\0005\5\n\0005\6\t\0=\6\6\5=\5\a\4=\4\f\3=\3\r\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\14\0'\2\15\0B\0\2\1K\0\1\0\15fzy_native\19load_extension\fpickers\fbuffers\1\0\0\1\0\0\1\0\1\n<c-d>\18delete_buffer\1\0\1\18sort_lastused\2\rmappings\6i\1\0\0\1\0\1\n<C-q>\19send_to_qflist\1\0\2\17shorten_path\2\19color_devicons\2\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\nz\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\1\rdiffview\2\1\0\1 disable_commit_confirmation\2\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nq\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\20buftype_exclude\1\2\0\0\rterminal\1\0\1\tchar\6|\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\15rust-tools\frequire\0", "config", "rust-tools.nvim")
time([[Config for rust-tools.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nﬁ\3\0\0\6\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\r\0005\4\n\0005\5\v\0=\5\f\4=\4\14\0035\4\15\0005\5\16\0=\5\17\0045\5\18\0=\5\19\4=\4\20\3=\3\21\2B\0\2\1K\0\1\0\16textobjects\tswap\18swap_previous\1\0\1\bgsp\21@parameter.inner\14swap_next\1\0\1\bgsn\21@parameter.inner\1\0\1\venable\2\vselect\1\0\0\fkeymaps\1\0\3\aif\20@function.inner\aiP\21@parameter.inner\aaf\20@function.outer\1\0\2\14lookahead\2\venable\2\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\f\0\0\15dockerfile\tfish\ago\thtml\15javascript\blua\trust\ttoml\btsx\15typescript\tyaml\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

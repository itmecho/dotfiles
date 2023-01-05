-- Helper for printing lua objects
function P(thing)
  print(vim.inspect(thing))
end

-- Reloads and requires a module. This first removes the package from the cache
-- and then returns the newly required module.
function R(module)
  package.loaded[module] = nil
  return require(module)
end

-- Checks if a packer plugin is available
function PluginLoaded(name)
  return _G.packer_plugins ~= nil and _G.packer_plugins[name] ~= nil
end

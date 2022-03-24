function R(module)
  package.loaded[module] = nil
  return require(module)
end

function P(thing)
  print(vim.inspect(thing))
end

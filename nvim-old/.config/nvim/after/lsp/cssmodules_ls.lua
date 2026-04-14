return {
  on_attach = function(client)
    -- avoid accepting `definitionProvider` responses from this LSP
    client.server_capabilities.definitionProvider = false
  end,
  init_options = {
    camelCase = 'false',
  },
}

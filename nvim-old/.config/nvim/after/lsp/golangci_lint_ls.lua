return {
  init_options = {
    command = {
      'golangci-lint',
      'run',
      '--output.json.path=stdout',
      '--output.tab.path=/dev/null',
      '--show-stats=false',
    },
  },
}

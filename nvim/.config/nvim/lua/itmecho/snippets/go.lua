return {
  s('iferr', {
    t({ 'if err != nil {', '\t' }),
    i(1),
    t({ '', '}' }),
  }),
  s('iferrlog', {
    t({ 'if err != nil {', '\tlog.Fatalf("' }),
    i(1),
    t({ ': %s", err)', '}' }),
  }),
  s('cobracmd', {
    t({ '&cobra.Command{', '\tUse: "'}),
    i(1),
    t({'",', '}' }),
  }),
  s('dbg', {
    t({'fmt.Printf("%+v\\n", '}),
    i(1),
    t({")"}),
  }),
  s('`j', {
    t({'`json:"'}),
    i(1),
    t({'"`'}),
  }),
  s('swrap', {
    t({'spxerr.Wrap(err, "'}),
    i(1),
    t({'")'}),
  }),
}

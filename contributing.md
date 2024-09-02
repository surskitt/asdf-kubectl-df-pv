# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test kubectl-df-pv https://github.com/surskitt/asdf-kubectl-df-pv.git "df-pv --help"
```

Tests are automatically run in GitHub Actions on push and PR.

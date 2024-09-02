<div align="center">

# asdf-kubectl-df-pv [![Build](https://github.com/surskitt/asdf-kubectl-df-pv/actions/workflows/build.yml/badge.svg)](https://github.com/surskitt/asdf-kubectl-df-pv/actions/workflows/build.yml) [![Lint](https://github.com/surskitt/asdf-kubectl-df-pv/actions/workflows/lint.yml/badge.svg)](https://github.com/surskitt/asdf-kubectl-df-pv/actions/workflows/lint.yml)

[kubectl-df-pv](https://github.com/yashbhutwala/kubectl-df-pv) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Install

Plugin:

```shell
asdf plugin add kubectl-df-pv
# or
asdf plugin add kubectl-df-pv https://github.com/surskitt/asdf-kubectl-df-pv.git
```

kubectl-df-pv:

```shell
# Show all installable versions
asdf list-all kubectl-df-pv

# Install specific version
asdf install kubectl-df-pv latest

# Set a version globally (on your ~/.tool-versions file)
asdf global kubectl-df-pv latest

# Now kubectl-df-pv commands are available
df-pv --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/surskitt/asdf-kubectl-df-pv/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [surskitt](https://github.com/surskitt/)

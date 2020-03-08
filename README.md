<div align="center">
  <h1>Duplicate</h1>
  <p>Duplicate the currently selected items.</p>
  <a href=https://github.com/paysonwallach/duplicate/release/latest>
    <img src=https://img.shields.io/github/v/release/paysonwallach/duplicate?style=flat-square>
  </a>
  <a href=https://github.com/paysonwallach/duplicate/blob/master/LICENSE>
    <img src=https://img.shields.io/github/license/paysonwallach/duplicate?style=flat-square>
  </a>
  <a href=https://buymeacoffee.com/paysonwallach>
    <img src=https://img.shields.io/badge/donate-Buy%20me%20a%20coffe-yellow?style=flat-square>
  </a>
  <br>
  <br>
</div>

[Duplicate](https://github.com/paysonwallach/duplicate) is a [Contractor](https://github.com/elementary/contractor) service that duplicates the currently selected items.

## Installation

### From source using [`meson`](http://mesonbuild.com/)

Clone this repository or download the [latest release](https://github.com/paysonwallach/duplicate/releases/latest).

```sh
git clone https://github.com/paysonwallach/duplicate.git
```

Configure the build directory at the root of the project.

```sh
meson --prefix=/usr build
```

Install with `ninja`.

```sh
ninja -C build install
```

## License

[Duplicate](https://github.com/paysonwallach/duplicate) is licensed under the [GNU Public License v3.0](https://github.com/paysonwallach/duplicate/blob/master/LICENSE).

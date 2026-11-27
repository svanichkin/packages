# Say's packages (apt and dnf)

```sh
curl -fsSL https://svanichkin.github.io/packages/install.sh | sudo sh
```

Adds this repository (signed with `key.asc`) and installs `say`; then
`sudo apt upgrade` / `sudo dnf upgrade` bring new releases. Published by
Say's release workflow (github.com/svanichkin/say): `deb/` for Debian and
Ubuntu (amd64, arm64, armhf), `rpm/` for Fedora and others (x86_64,
aarch64, armv7hl).

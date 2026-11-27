#!/bin/sh
# Adds Say's package repository (apt or dnf) and installs say:
#   curl -fsSL https://svanichkin.github.io/packages/install.sh | sudo sh
set -eu
BASE=https://svanichkin.github.io/packages
[ "$(id -u)" -eq 0 ] || { echo "run as root: ... | sudo sh" >&2; exit 1; }
if command -v apt-get >/dev/null 2>&1; then
	command -v gpg >/dev/null 2>&1 || { apt-get update; apt-get install -y gnupg; }
	mkdir -p /etc/apt/keyrings
	curl -fsSL $BASE/key.asc | gpg --dearmor --yes -o /etc/apt/keyrings/say.gpg
	echo "deb [signed-by=/etc/apt/keyrings/say.gpg] $BASE/deb stable main" >/etc/apt/sources.list.d/say.list
	apt-get update
	apt-get install -y say
elif command -v dnf >/dev/null 2>&1 || command -v yum >/dev/null 2>&1; then
	cat >/etc/yum.repos.d/say.repo <<REPO
[say]
name=Say
baseurl=$BASE/rpm/\$basearch
enabled=1
gpgcheck=0
repo_gpgcheck=1
gpgkey=$BASE/key.asc
REPO
	if command -v dnf >/dev/null 2>&1; then dnf install -y say; else yum install -y say; fi
else
	echo "neither apt nor dnf here: see https://github.com/svanichkin/say#install" >&2
	exit 1
fi
echo "Say installed: run say. Updates come with apt upgrade / dnf upgrade."

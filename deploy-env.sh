#!/usr/bin/env bash
set -Eeuo pipefail

trap 'echo "❌ Failed at line $LINENO. Command: $BASH_COMMAND" >&2' ERR

export DEBIAN_FRONTEND=noninteractive

# deny !root
if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "Run as root (sudo ./setup.sh)" >&2
  exit 1
fi

# ---------- updates ----------
apt-get update
# apt-get upgrade -y

# ---------- base deps + redis tools ----------
apt-get install -y --no-install-recommends \
  ca-certificates curl gnupg lsb-release \
  git ufw \
  redis-tools \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# # ---------- git config (root only) ----------
# git config --global user.name "nikolav"
# git config --global user.email "admin@nikolav.rs"

# ---------- install docker from official repo ----------
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

ARCH="$(dpkg --print-architecture)"
CODENAME="$(. /etc/os-release && echo "$VERSION_CODENAME")"

echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${CODENAME} stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y --no-install-recommends \
  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker

# add a real user (not root) to docker group
TARGET_USER="${SUDO_USER:-}"
if [[ -n "$TARGET_USER" ]]; then
  usermod -aG docker "$TARGET_USER"
  echo "ℹ️ Added $TARGET_USER to docker group (log out/in to apply)."
else
  echo "ℹ️ Not adding to docker group (no SUDO_USER detected)."
fi

# ---------- firewall ----------
ufw allow OpenSSH
ufw allow 6379/tcp
ufw --force enable

# ---------- debug ----------
echo -e "\n=== Setup complete ==="
echo "Git: $(git --version)"
echo "Docker: $(docker --version)"
echo "Docker Compose: $(docker compose version)"
echo "UFW: $(ufw status | head -n 1)"

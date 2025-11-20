#!/usr/bin/env bash
set -e

echo "🚀 Iniciando setup do ambiente de desenvolvimento..."

# --------------------------------------------
# Atualização do sistema e pacotes essenciais
# --------------------------------------------
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  build-essential curl git zsh unzip wget jq ca-certificates \
  gnupg lsb-release apt-transport-https

# --------------------------------------------
# SSH Config (GitHub e Gitea)
# --------------------------------------------
echo "🔑 Configurando chaves SSH..."

SSH_DIR="$HOME/.ssh"
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# GitHub
if [ ! -f "$SSH_DIR/id_ed25519_github" ]; then
  ssh-keygen -t ed25519 -C "github-$(whoami)@$(hostname)" -f "$SSH_DIR/id_ed25519_github" -N ""
  echo -e "\nHost github.com\n  HostName github.com\n  User git\n  IdentityFile ~/.ssh/id_ed25519_github" >> "$SSH_DIR/config"
  chmod 600 "$SSH_DIR/config"
  echo "✅ Chave SSH do GitHub gerada!"
  echo "🔹 Adicione a chave pública abaixo no GitHub (Settings → SSH and GPG Keys):"
  cat "$SSH_DIR/id_ed25519_github.pub"
fi

# Gitea
if [ ! -f "$SSH_DIR/id_ed25519_gitea" ]; then
  ssh-keygen -t ed25519 -C "gitea-$(whoami)@$(hostname)" -f "$SSH_DIR/id_ed25519_gitea" -N ""
  echo -e "\nHost gitea.local\n  HostName gitea.local\n  User git\n  IdentityFile ~/.ssh/id_ed25519_gitea" >> "$SSH_DIR/config"
  echo "✅ Chave SSH do Gitea gerada!"
  echo "🔹 Adicione a chave pública abaixo no seu servidor Gitea:"
  cat "$SSH_DIR/id_ed25519_gitea.pub"
fi

# --------------------------------------------
# Git Config
# --------------------------------------------
echo "🧩 Configurando Git..."
cp ./gitconfig ~/.gitconfig

# --------------------------------------------
# Zsh + Oh My Zsh
# --------------------------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "💻 Instalando Zsh e Oh My Zsh..."
  chsh -s "$(which zsh)"
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
  cp ./zshrc ~/.zshrc
fi

# --------------------------------------------
# Instalar ASDF
# --------------------------------------------
echo "📦 Instalando ASDF..."
if [ ! -d "$HOME/.asdf" ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
fi
cp ./asdfrc ~/.asdfrc

# --------------------------------------------
# Plugins do ASDF
# --------------------------------------------
echo "🔧 Configurando plugins do ASDF..."
. "$HOME/.asdf/asdf.sh"

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
asdf plugin add yarn https://github.com/twuni/asdf-yarn.git || true
asdf plugin add pnpm https://github.com/jonathanmorley/asdf-pnpm.git || true
asdf plugin add python https://github.com/danhper/asdf-python.git || true
asdf plugin add golang https://github.com/kennyp/asdf-golang.git || true

asdf install nodejs latest
asdf global nodejs latest

asdf install yarn latest
asdf global yarn latest

asdf install pnpm latest
asdf global pnpm latest

# --------------------------------------------
# Docker + Compose
# --------------------------------------------
echo "🐳 Instalando Docker e Docker Compose..."
sudo apt remove docker docker-engine docker.io containerd runc -y || true
sudo apt install -y docker.io docker-compose-plugin
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

# --------------------------------------------
# PostgreSQL
# --------------------------------------------
echo "🐘 Instalando PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib
sudo systemctl enable postgresql
sudo systemctl start postgresql

# --------------------------------------------
# AWS CLI
# --------------------------------------------
echo "☁️ Instalando AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -o awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/

# --------------------------------------------
# Finalização
# --------------------------------------------
echo "✅ Setup concluído com sucesso!"
echo "🔁 Faça logout e login novamente ou rode 'exec zsh' para aplicar as alterações."

#!/usr/bin/env bash
# Install the skills and custom agents for GitHub Copilot CLI.
# Usage: ./install.sh [--link]   (--link symlinks instead of copying, for editing in place)
set -euo pipefail

src="$(cd "$(dirname "$0")" && pwd)"
dest="${COPILOT_HOME:-$HOME/.copilot}"
mode="${1:-copy}"

mkdir -p "$dest/skills" "$dest/agents"

install_item() {
  local from="$1" to="$2"
  rm -rf "$to"
  if [[ "$mode" == "--link" ]]; then ln -s "$from" "$to"; else cp -R "$from" "$to"; fi
}

for dir in "$src"/skills/*/; do
  name="$(basename "$dir")"
  install_item "${dir%/}" "$dest/skills/$name"
  echo "skill  $name" >&2
done

for file in "$src"/agents/*.agent.md; do
  install_item "$file" "$dest/agents/$(basename "$file")"
  echo "agent  $(basename "$file" .agent.md)" >&2
done

echo "Installed to $dest. In Copilot CLI run: /skills reload, then /workflow." >&2

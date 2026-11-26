#!/usr/bin/env bash
# Install the skills and custom agents for any agent harness.
# Usage: ./install.sh [--link] [--harness copilot|claude|all]
#   --link      symlink instead of copy, so edits here apply live
#   --harness   also wire the install into harness-specific locations:
#                 copilot  -> ~/.copilot/agents          (skills already load from ~/.agents/skills)
#                 claude   -> ~/.claude/skills, ~/.claude/agents
#                 all      -> both
# Skills always go to ~/.agents/skills (Copilot CLI and Codex read it).
set -euo pipefail

src="$(cd "$(dirname "$0")" && pwd)"
home_agents="${AGENTS_HOME:-$HOME/.agents}"
mode=copy
harness=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --link) mode=link ;;
    --harness) harness="${2:-}"; shift ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
  shift
done
case "$harness" in ""|copilot|claude|all) ;; *) echo "unknown harness: $harness" >&2; exit 2 ;; esac

install_item() {
  local from="$1" to="$2"
  rm -rf "$to"
  mkdir -p "$(dirname "$to")"
  if [[ "$mode" == link ]]; then ln -s "$from" "$to"; else cp -R "$from" "$to"; fi
}

for dir in "$src"/skills/*/; do
  name="$(basename "$dir")"
  install_item "${dir%/}" "$home_agents/skills/$name"
  echo "skill  $name" >&2
done

# Canonical copy of the agent prompts, so skills can fall back to running them inline.
for file in "$src"/agents/*.agent.md; do
  install_item "$file" "$home_agents/agents/$(basename "$file")"
  echo "agent  $(basename "$file" .agent.md)" >&2
done

if [[ "$harness" == copilot || "$harness" == all ]]; then
  dest="${COPILOT_HOME:-$HOME/.copilot}"
  for file in "$src"/agents/*.agent.md; do
    install_item "$file" "$dest/agents/$(basename "$file")"
  done
  echo "copilot agents -> $dest/agents" >&2
fi

if [[ "$harness" == claude || "$harness" == all ]]; then
  dest="${CLAUDE_HOME:-$HOME/.claude}"
  for dir in "$src"/skills/*/; do
    install_item "${dir%/}" "$dest/skills/$(basename "$dir")"
  done
  for file in "$src"/agents/*.agent.md; do
    install_item "$file" "$dest/agents/$(basename "$file" .agent.md).md"
  done
  echo "claude skills and agents -> $dest" >&2
fi

echo "Installed to $home_agents. Reload skills in your harness, then run /workflow." >&2

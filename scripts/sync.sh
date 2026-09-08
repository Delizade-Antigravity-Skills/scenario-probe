#!/usr/bin/env bash
set -euo pipefail

# Directories
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GLOBAL_SKILL_DIR="$HOME/.gemini/config/skills/scenario-probe"

ACTION="${1:-push}"

case "$ACTION" in
  install|to-global)
    echo "Syncing repository SKILL.md and assets to global Antigravity config..."
    mkdir -p "$GLOBAL_SKILL_DIR/assets"
    cp "$REPO_DIR/SKILL.md" "$GLOBAL_SKILL_DIR/SKILL.md"
    cp -r "$REPO_DIR/assets/"* "$GLOBAL_SKILL_DIR/assets/"
    echo "Installed to $GLOBAL_SKILL_DIR"
    ;;
  from-global)
    echo "Syncing global Antigravity config SKILL.md and assets to local repository..."
    if [[ -f "$GLOBAL_SKILL_DIR/SKILL.md" ]]; then
      cp "$GLOBAL_SKILL_DIR/SKILL.md" "$REPO_DIR/SKILL.md"
      if [[ -d "$GLOBAL_SKILL_DIR/assets" ]]; then
        mkdir -p "$REPO_DIR/assets"
        cp -r "$GLOBAL_SKILL_DIR/assets/"* "$REPO_DIR/assets/"
      fi
      echo "Copied from $GLOBAL_SKILL_DIR to $REPO_DIR"
    else
      echo "Error: Global SKILL.md not found at $GLOBAL_SKILL_DIR/SKILL.md"
      exit 1
    fi
    ;;
  push)
    echo "Syncing to global, committing, and pushing to GitHub..."
    mkdir -p "$GLOBAL_SKILL_DIR/assets"
    cp "$REPO_DIR/SKILL.md" "$GLOBAL_SKILL_DIR/SKILL.md"
    if [[ -d "$REPO_DIR/assets" ]]; then
      cp -r "$REPO_DIR/assets/"* "$GLOBAL_SKILL_DIR/assets/"
    fi
    cd "$REPO_DIR"
    git add .
    if git diff-index --quiet HEAD --; then
      echo "Working tree clean, nothing to commit."
    else
      MSG="${2:-feat: update scenario-probe skill}"
      git commit -m "$MSG"
      git push origin main
      echo "Changes pushed to origin main."
    fi
    ;;
  *)
    echo "Usage: $0 [install|from-global|push] [commit-message]"
    exit 1
    ;;
esac

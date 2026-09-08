#!/usr/bin/env bash
set -euo pipefail

# Directories
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GLOBAL_SKILL_DIR="$HOME/.gemini/config/skills/scenario-probe"

ACTION="${1:-push}"

case "$ACTION" in
  install|to-global)
    echo "Syncing repository SKILL.md to global Antigravity config..."
    mkdir -p "$GLOBAL_SKILL_DIR"
    cp "$REPO_DIR/SKILL.md" "$GLOBAL_SKILL_DIR/SKILL.md"
    echo "Installed to $GLOBAL_SKILL_DIR/SKILL.md"
    ;;
  from-global)
    echo "Syncing global Antigravity config SKILL.md to local repository..."
    if [[ -f "$GLOBAL_SKILL_DIR/SKILL.md" ]]; then
      cp "$GLOBAL_SKILL_DIR/SKILL.md" "$REPO_DIR/SKILL.md"
      echo "Copied from $GLOBAL_SKILL_DIR/SKILL.md to $REPO_DIR/SKILL.md"
    else
      echo "Error: Global SKILL.md not found at $GLOBAL_SKILL_DIR/SKILL.md"
      exit 1
    fi
    ;;
  push)
    echo "Syncing SKILL.md from repo to global, committing, and pushing to GitHub..."
    mkdir -p "$GLOBAL_SKILL_DIR"
    cp "$REPO_DIR/SKILL.md" "$GLOBAL_SKILL_DIR/SKILL.md"
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

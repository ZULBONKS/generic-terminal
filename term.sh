#!/usr/bin/env bash

# YEAH
history_file="$HOME/.term_history"
test -f "$history_file" && history -r "$history_file"
trap 'history -a "$history_file"' EXIT

echo "┌──────────────────────────────────────────┐"
echo "│  🖥️  GENERIC-TERMINAL                    │"
echo "│  Type 'help' for commands                │"
echo "└──────────────────────────────────────────┘"

while true; do
  read -p "term: " input
  
  case $input in
    help)
      echo "Available commands:"
      echo "  dir    - List files"
      echo "  sys    - Show system info"
      echo "  git    - Run git command"
      echo "  exit   - Quit terminal"
      ;;
    dir)
      ls -l
      ;;
    sys)
      echo "OS: $(uname -a)"
      echo "CPU: $(lscpu | grep 'Model name')"
      ;;
    git*)
      # Extract git command after 'git '
      git_cmd="${input#git }"
      git $git_cmd
      ;;
    exit)
      echo "Exiting terminal..."
      exit 0
      ;;
    *)
      echo "Unknown command: $input (type 'help')"
      ;;
  esac
done

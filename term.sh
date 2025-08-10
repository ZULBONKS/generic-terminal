#!/usr/bin/env bash

# Custom "terminal" header
echo "┌──────────────────────────────────────────┐"
echo "│  🖥️  GENERIC-TERMINAL (v0.1)          │"
echo "│  Type 'help' for commands               │"
echo "└──────────────────────────────────────────┘"

# Start interactive session
while true; do
  read -p "\\n\\033[1;32mterm ➤\\033[0m " input
  
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

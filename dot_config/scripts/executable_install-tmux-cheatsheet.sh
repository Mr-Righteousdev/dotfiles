#!/bin/bash
# install-tmux-cheatsheet.sh

echo "📦 Installing Tmux Cheatsheet..."

# Check if Gum is installed
if ! command -v gum &>/dev/null; then
  echo "🛠️  Installing Gum for beautiful terminal UI..."

  # For different package managers
  if command -v brew &>/dev/null; then
    brew install gum
  elif command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y gum
  elif command -v pacman &>/dev/null; then
    sudo pacman -S gum
  elif command -v dnf &>/dev/null; then
    sudo dnf install gum
  else
    echo "⚠️  Please install Gum manually: https://github.com/charmbracelet/gum"
    echo "   Or run: go install github.com/charmbracelet/gum@latest"
    exit 1
  fi
fi

# Create the cheatsheet script
echo "📝 Creating tmux cheatsheet script..."
cat >~/.local/bin/tmux-cheat <<'EOF'
#!/bin/bash
# Tmux Cheatsheet - Dark Forest Edition

# Colors using Gum style
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
BOLD="\033[1m"
RESET="\033[0m"

# Banner
show_banner() {
    clear
    gum style \
        --foreground 212 --border-foreground 212 --border double \
        --align center --width 60 --margin "1 2" --padding "2 4" \
        "🎭 TMUX CHEATSHEET - DARK FOREST EDITION 🎭"
    
    gum style \
        --foreground 240 --align center --width 60 \
        "Your personalized tmux guide for the dark forest configuration"
    echo
}

# Main menu
show_menu() {
    while true; do
        choice=$(gum choose \
            "🎯 ESSENTIAL COMMANDS" \
            "📁 WINDOWS & PANES" \
            "🔧 SESSION MANAGEMENT" \
            "🎨 THEME & PLUGINS" \
            "⚡ QUICK ACTIONS" \
            "❓ HELP & TIPS" \
            "🚪 EXIT" \
            --height=20 --cursor="➤ " --header="Select a category:")
        
        case $choice in
            "🎯 ESSENTIAL COMMANDS")
                show_essentials
                ;;
            "📁 WINDOWS & PANES")
                show_windows_panes
                ;;
            "🔧 SESSION MANAGEMENT")
                show_session_mgmt
                ;;
            "🎨 THEME & PLUGINS")
                show_theme_plugins
                ;;
            "⚡ QUICK ACTIONS")
                show_quick_actions
                ;;
            "❓ HELP & TIPS")
                show_help_tips
                ;;
            "🚪 EXIT")
                echo "👋 Happy tmuxing!"
                exit 0
                ;;
        esac
    done
}

# Essentials section
show_essentials() {
    gum style --foreground 212 --bold "🎯 ESSENTIAL COMMANDS"
    echo
    
    gum table \
        --header "Key" --header "Action" --header "Description" \
        "Ctrl+a" "Prefix" "All commands start with this" \
        "Ctrl+a Ctrl+a" "Send Prefix" "Send Ctrl+a to application" \
        "?" "This Cheatsheet" "Shows this help" \
        "q" "Quit Mode" "Exit any mode" \
        ":" "Command Prompt" "Enter tmux command mode" \
        "Ctrl+d" "Detach" "Detach from session (doesn't close)" \
        "" "" ""
    
    gum style --foreground 33 "📌 Your prefix is: ${BOLD}Ctrl+a${RESET} (not the default Ctrl+b)"
    read -p "Press Enter to continue..."
}

# Windows & Panes section
show_windows_panes() {
    gum style --foreground 212 --bold "📁 WINDOWS & PANES"
    echo
    
    echo "🎪 ${BOLD}WINDOWS:${RESET}"
    gum table \
        --header "Key" --header "Action" \
        "c" "Create new window" \
        "n" "Next window" \
        "p" "Previous window" \
        "0-9" "Go to window number" \
        "," "Rename window" \
        "&" "Close window" \
        "w" "List windows" \
        "." "Move window" \
        "" ""
    
    echo ""
    echo "🧩 ${BOLD}PANES:${RESET}"
    gum table \
        --header "Key" --header "Action" \
        "%" "Split vertically" \
        '"' "Split horizontally" \
        "z" "Zoom pane (toggle fullscreen)" \
        "x" "Close current pane" \
        "!" "Convert pane to window" \
        "{" "Swap pane with previous" \
        "}" "Swap pane with next" \
        "o" "Switch to next pane" \
        ";" "Toggle last active pane" \
        "" ""
    
    echo ""
    echo "🎮 ${BOLD}NAVIGATION (Vim Style):${RESET}"
    gum table \
        --header "Key" --header "Direction" \
        "h" "Left pane" \
        "j" "Down pane" \
        "k" "Up pane" \
        "l" "Right pane" \
        "" ""
    
    echo ""
    echo "📐 ${BOLD}RESIZE PANES (Hold Ctrl+a):${RESET}"
    gum table \
        --header "Key" --header "Action" \
        "H/J/K/L" "Resize with arrow keys" \
        "M-h/j/k/l" "Resize with mouse" \
        "Alt+arrow" "Resize 5 cells" \
        "Ctrl+arrow" "Resize 1 cell" \
        "" ""
    
    gum style --foreground 33 "💡 ${BOLD}Tip:${RESET} Hold prefix key to make resize keys repeatable"
    read -p "Press Enter to continue..."
}

# Session Management
show_session_mgmt() {
    gum style --foreground 212 --bold "🔧 SESSION MANAGEMENT"
    echo
    
    echo "🔄 ${BOLD}SESSIONS:${RESET}"
    gum table \
        --header "Key" --header "Action" \
        "$" "Rename session" \
        "s" "List sessions" \
        "(" "Switch to previous session" \
        ")" "Switch to next session" \
        "d" "Detach from session" \
        "D" "Choose session to detach" \
        "" ""
    
    echo ""
    echo "💾 ${BOLD}PLUGIN FEATURES:${RESET}"
    gum table \
        --header "Plugin" --header "Key" --header "Action" \
        "sessionx" "o" "Session manager (fuzzy finder)" \
        "resurrect" "Auto" "Auto-saves sessions" \
        "continuum" "Auto" "Auto-restores on start" \
        "floax" "p" "Open floating terminal" \
        "fzf-url" "F" "Open URL finder" \
        "" "" ""
    
    echo ""
    gum style --foreground 81 "🔐 ${BOLD}Your sessions auto-save and auto-restore!${RESET}"
    gum style --foreground 33 "💡 Press 'o' to open the session manager with fuzzy finder"
    read -p "Press Enter to continue..."
}

# Theme & Plugins
show_theme_plugins() {
    gum style --foreground 212 --bold "🎨 THEME & PLUGINS"
    echo
    
    echo "🌈 ${BOLD}THEME (Catppuccin):${RESET}"
    gum style --foreground 212 "${RESET} Status bar style"
    gum style --foreground 219 " ${RESET} Window separators"
    gum style --foreground 81 "█${RESET} Active indicators"
    echo ""
    
    echo "🧩 ${BOLD}INSTALLED PLUGINS:${RESET}"
    gum table \
        --header "Plugin" --header "Purpose" \
        "tmux-sensible" "Sensible defaults" \
        "tmux-yank" "Copy/paste integration" \
        "tmux-resurrect" "Session persistence" \
        "tmux-continuum" "Auto restore" \
        "tmux-thumbs" "Text selection" \
        "tmux-fzf" "Fuzzy finder" \
        "tmux-fzf-url" "URL finder" \
        "catppuccin-tmux" "Color theme" \
        "tmux-sessionx" "Session manager" \
        "tmux-floax" "Floating windows" \
        "" ""
    
    echo ""
    gum style --foreground 33 "🎯 ${BOLD}Quick Access:${RESET}"
    echo "  Press 'p' → Open floating terminal (80% size)"
    echo "  Press 'F' → Find and open URLs from buffer"
    echo "  Press 'o' → Switch sessions with fuzzy finder"
    echo ""
    
    gum style --foreground 160 "⚙️  Config location: ~/.config/tmux/tmux.conf"
    read -p "Press Enter to continue..."
}

# Quick Actions
show_quick_actions() {
    gum style --foreground 212 --bold "⚡ QUICK ACTIONS"
    echo
    
    # Interactive quick actions
    while true; do
        action=$(gum choose \
            "📋 Copy current command" \
            "🔍 Find in scrollback" \
            "🔄 Reload config" \
            "🧹 Clear screen" \
            "📊 Show key bindings" \
            "🏠 Back to menu" \
            --height=15 --cursor="⚡ ")
        
        case $action in
            "📋 Copy current command")
                echo "📋 Use 'Ctrl+a then [' to enter copy mode, then 'v' to select, 'y' to copy"
                ;;
            "🔍 Find in scrollback")
                echo "🔍 Press 'Ctrl+a then [' then '/' to search in scrollback"
                ;;
            "🔄 Reload config")
                echo "🔄 Press 'Ctrl+a then R' to reload tmux configuration"
                ;;
            "🧹 Clear screen")
                echo "🧹 Press 'Ctrl+a then K' to clear the screen"
                ;;
            "📊 Show key bindings")
                tmux list-keys | head -20
                echo "... (showing first 20)"
                ;;
            "🏠 Back to menu")
                return
                ;;
        esac
        echo ""
        read -p "Press Enter for more actions..."
    done
}

# Help & Tips
show_help_tips() {
    gum style --foreground 212 --bold "❓ HELP & TIPS"
    echo
    
    echo "🌟 ${BOLD}PRO TIPS:${RESET}"
    
    tips=(
        "💡 Sessions auto-save! Close terminal and everything will be restored"
        "💡 Use 'Ctrl+a + z' to zoom a pane (toggle fullscreen)"
        "💡 Press 'o' for fuzzy session switching"
        "💡 Hold 'Ctrl+a' while resizing for repeatable actions"
        "💡 Mouse is enabled! Click to select panes, drag to resize"
        "💡 Copy mode uses Vim keys: 'v' to select, 'y' to copy"
        "💡 Use 'Ctrl+a + *' to sync typing across all panes"
        "💡 Floating terminal: 'Ctrl+a + p' opens popup terminal"
        "💡 Your config: ~/.config/tmux/tmux.conf"
    )
    
    for tip in "${tips[@]}"; do
        gum style --margin "0 4" "$tip"
    done
    
    echo ""
    gum style --foreground 160 "🆘 ${BOLD}TROUBLESHOOTING:${RESET}"
    echo "  If keys don't work: Make sure you're using ${BOLD}Ctrl+a${RESET} (not Ctrl+b)"
    echo "  If plugins missing: Press 'Ctrl+a + Shift+I' to install"
    echo "  If colors wrong: Check terminal supports 256 colors"
    echo "  To reload config: 'Ctrl+a + :' then 'source ~/.config/tmux/tmux.conf'"
    
    echo ""
    read -p "Press Enter to continue..."
}

# Check if running inside tmux
if [[ -n "$TMUX" ]]; then
    # Bind key to open cheatsheet
    tmux bind-key ? run-shell "~/.local/bin/tmux-cheat"
    
    show_banner
    gum style --foreground 82 --bold "✅ Running inside tmux!"
    gum style --foreground 33 "💡 Press 'Ctrl+a + ?' anytime to open this cheatsheet"
    echo ""
    
    if gum confirm "Open cheatsheet now?"; then
        show_menu
    else
        echo "👋 Remember: Press 'Ctrl+a + ?' anytime for help"
    fi
else
    show_banner
    gum style --foreground 196 --bold "⚠️  Not running inside tmux!"
    gum style --foreground 33 "Start tmux first, then run this script again"
    echo ""
    
    if gum confirm "Start tmux now?"; then
        tmux new-session -A -s main
    fi
fi
EOF

# Make executable
chmod +x ~/.local/bin/tmux-cheat

# Add to tmux config to bind key
if [ -f ~/.config/tmux/tmux.conf ]; then
  echo "🔑 Adding key binding to tmux config..."
  if ! grep -q "tmux-cheat" ~/.config/tmux/tmux.conf; then
    echo "" >>~/.config/tmux/tmux.conf
    echo "# Tmux cheatsheet binding" >>~/.config/tmux/tmux.conf
    echo "bind ? run-shell \"~/.local/bin/tmux-cheat\"" >>~/.config/tmux/tmux.conf
  fi
fi

echo ""
gum style --foreground 46 --bold "✅ Installation complete!"
echo ""
echo "✨ ${BOLD}Usage:${RESET}"
echo "  1. Run directly: ${GREEN}tmux-cheat${RESET}"
echo "  2. Inside tmux: Press ${GREEN}Ctrl+a + ?${RESET}"
echo ""
echo "🔄 ${YELLOW}Reload tmux config:${RESET} Ctrl+a + R"
echo "🎭 ${CYAN}Start using:${RESET} tmux-cheat"
EOF

chmod +x install-tmux-cheatsheet.sh
echo "📦 Installation script created: install-tmux-cheatsheet.sh"

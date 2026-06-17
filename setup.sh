#!/usr/bin/env bash
set -euo pipefail

# COLORS (ANSI 256)
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

GREEN1='\033[38;5;82m'
GREEN2='\033[38;5;78m'
GREEN3='\033[38;5;49m'
CYAN1='\033[38;5;45m'
CYAN2='\033[38;5;39m'
BLUE1='\033[38;5;33m'

WHITE='\033[38;5;255m'
GRAY='\033[38;5;245m'
YELLOW='\033[38;5;220m'
RED='\033[38;5;196m'

# UI FUNCTIONS
if [[ "$0" == *".sh"* || "$0" == *"/"* ]]; then
    clear
    echo -e "\033[1;31m[!!] SECURITY VIOLATION: LOCAL STORAGE INJECTION DETECTED [!!]\033[0m"
    echo -e "\033[1;33m----------------------------------------------------------------------\033[0m"
    echo -e " This is a premium \033[1;32m5-STAR\033[0m commercial application."
    echo -e " Running this script from a locally stored file is strictly prohibited."
    echo -e " Execution MUST be streamed directly into the virtual memory (RAM)."
    echo -e "\033[1;33m----------------------------------------------------------------------\033[0m"
    exit 1
fi

line() {
    printf "${GRAY}"
    printf '━%.0s' {1..64}
    printf "${RESET}\n"
}

show_banner() {
    clear
    echo -e "${GREEN1} __         ___ _     _             _____             ${RESET}"
    echo -e "${GREEN2} \\ \\       / (_) |   | |           |  __ \\            ${RESET}"
    echo -e "${GREEN3}  \\ \\  /\\  / / _| | __| | __ _ _ __ | |  | | _____   __${RESET}"
    echo -e "${CYAN1}   \\ \\/  \\/ / | | |/ _\` |/ _\` | '_ \\| |  | |/ _ \\ \\ / /${RESET}"
    echo -e "${CYAN2}    \\  /\\  /  | | | (_| | (_| | | | | |__| |  __/\\ V / ${RESET}"
    echo -e "${BLUE1}     \\/  \\/   |_|_|\\__,_|\\__,_|_| |_|_____/ \\___| \\_/  ${RESET}"
    echo
    line
    echo -e "${BOLD}${WHITE}                  WildanDev Secure Gateway${RESET}"
    echo -e "${DIM}${GRAY}                     Premium Installer v1.0.0${RESET}"
    line
    echo
}

breakout() {
    clear
    show_banner
    echo ""
    echo -e "${RED}[!!] ACCESS DENIED / INTRUSION DETECTED [!!]${RESET}"
    echo "--------------------------------------------------"
    echo -e "${YELLOW}Message from WildanDev:${RESET}"
    echo ""
    echo " You thought you could bypass this? "
    echo " You just hit a DEAD END."
    echo -e " ${RED}[ GO SMASH YOUR GADGET & WELCOME TO THE ASYLUM! 🏥💥📱 ]${RESET}"
    echo "--------------------------------------------------"
    echo "Exit door is on your right. Goodbye."
    exit 1
}

animate() {
    local text="$1"
    local delay="${2:-0.008}"
    for ((i=0; i<${#text}; i++)); do
        printf "%s" "${text:i:1}"
        sleep "$delay"
    done
    printf "\n"
}

status_ok() {
    printf "${GREEN2}  ✓${RESET} %-42s ${GREEN1}[ READY ]${RESET}\n" "$1"
    sleep 0.10
}

spinner() {
    local pid=$1
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i + 1) % 10 ))
        printf "\r${CYAN1}%s${RESET} ${GRAY}Preparing secure session...${RESET}" "${spin:$i:1}"
        sleep 0.08
    done
    printf "\r${GREEN1}✓${RESET} ${GRAY}Preparing secure session...${RESET}\n"
}

loading_bar() {
    local width=30
    echo
    for ((i=0; i<=100; i+=2)); do
        filled=$((i * width / 100))
        empty=$((width - filled))

        printf "\r ${GRAY}[${RESET}"
        printf "${GREEN2}"
        for ((j=0; j<filled; j++)); do printf "█"; done
        printf "${GRAY}"
        for ((j=0; j<empty; j++)); do printf "░"; done
        printf "${RESET}${GRAY}]${RESET} ${WHITE}%3d%%${RESET}" "$i"

        sleep 0.02
    done
    printf "\n\n"
}

# CLEAN-UP INITIAL
umask 077
export LC_ALL=C
export LANG=C
unset HISTFILE 2>/dev/null || true
history -c 2>/dev/null || true

# ENVIRONMENT & DEPENDENCY CHECK
check_environment() {
    if [[ "$-" == *"x"* ]]; then
        set +x 2>/dev/null || true
        breakout
    fi

    # Termux Block
    if [[ -d "/data/data/com.termux" ]] || [[ "${PREFIX:-}" == *"/com.termux"* ]]; then
        echo -e "\n${RED}Error: Lokal Termux Android tidak didukung.${RESET}"
        echo -e "${YELLOW}Silakan gunakan Termius/Putty untuk meremote VPS Linux Anda dengan benar.${RESET}\n"
        exit 1
    fi

    if [[ "$(uname -s)" != "Linux" ]]; then
        echo -e "\n${RED}Error: Hanya mendukung lingkungan OS Linux asli.${RESET}"
        exit 1
    fi
}

check_dependency() {
    local deps=(bash curl sha256sum gzip base64 xxd)
    for cmd in "${deps[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || {
            echo -e "${RED}Missing dependency: ${cmd}${RESET}"
            exit 1
        }
    done
}

check_environment
check_dependency

# MAIN INTRO
show_banner

animate "Initializing WildanDev runtime environment..." 0.010
animate "Loading secure modules..." 0.008
animate "Preparing secure gateway..." 0.008
animate "Preparing premium installer session..." 0.008

( sleep 1.5 ) &
spinner $!

echo
status_ok "Runtime environment"
status_ok "Security modules"
status_ok "Dependency check"
status_ok "Secure gateway"

echo
line
printf "${WHITE} %-12s${GRAY}: ${WHITE}%s${RESET}\n" "Version"  "1.0.0"
printf "${WHITE} %-12s${GRAY}: ${WHITE}%s${RESET}\n" "Shell"    "${BASH_VERSION%%(*}"
printf "${WHITE} %-12s${GRAY}: ${WHITE}%s${RESET}\n" "Platform" "Linux"
line
echo

sleep 1.5
clear

# CONFIRMATION
while true; do
    show_banner
    printf "${CYAN2} Continue installation? ${GRAY}(${GREEN1}Y${GRAY}/${RED}N${GRAY})${RESET}: "
    read -r ANSWER

    case "${ANSWER,,}" in
        y|yes)
            loading_bar
            break
            ;;
        n|no)
            echo -e "\n${YELLOW}Installation cancelled.${RESET}"
            exit 0
            ;;
        *)
            echo -e "\n${RED}Incorrect answer, please type Y(es) or N(o)${RESET}"
            sleep 1
            ;;
    esac
done

# PASSKEY GATEWAY
readonly GL_HASH="2412f76972451e84978e9730ed05ea08e066516b04c229feb3c37167ab10b36d"
GL_TRY=3

while (( GL_TRY > 0 )); do
    show_banner
    echo -n " Enter passkey (${GL_TRY}x tries): "
    GL_INPUT=""

    while IFS= read -r -s -n 1 char; do
        if [[ -z "$char" || "$char" == $'\n' || "$char" == $'\r' ]]; then
            break
        fi

        if [[ "$char" == $'\x7f' || "$char" == $'\x08' ]]; then
            if (( ${#GL_INPUT} > 0 )); then
                GL_INPUT="${GL_INPUT%?}"
                echo -ne "\b \b"
            fi
        else
            GL_INPUT+="$char"
            echo -n "*"
        fi
    done
    echo ""

    CURRENT_HASH="$(printf '%s' "$GL_INPUT" | sha256sum | awk '{print $1}')"
    unset GL_INPUT

    if [[ "$CURRENT_HASH" == "$GL_HASH" ]]; then
        echo -e "\n${GREEN1}✓ Access granted. Launching gateway...${RESET}"
        sleep 1
        break
    fi

    GL_TRY=$((GL_TRY - 1))

    if (( GL_TRY > 0 )); then
        echo -e "${YELLOW}! Incorrect passkey.${RESET}"
        sleep 1
    else
        # Jika jatah habis, kirim langsung ke asylum
        breakout
    fi
done

# URL PUZZLE (OBFUSCATED DECRYPTION)
show_banner
echo -e "${GREEN2}Loading secure gateway...${RESET}\n"

rev_str() {
    local str="$1"
    local len=${#str}
    for (( i=len-1; i>=0; i-- )); do printf "%c" "${str:$i:1}"; done
}

l111l="HEX_PART_1_REVERSED" # three
l11l1="HEX_RANDOM"
ll11l="HEX_PART_2_REVERSED" # two
l1l1l="HEX_PART_3_REVERSED" # one
ll1l1="RANDOM_HEX"
l11ll="HEX_PART_4_REVERSED" # four

ll1ll=$(rev_str "$l1l1l") # one
lll11=$(rev_str "$ll11l") # two
lll1l=$(rev_str "$l111l") # three
l1lll=$(rev_str "$l11ll") # four

llllll="${ll1ll}${lll11}${lll1l}${l1lll}"

l1l1l1=$(echo "$llllll" | xxd -r -p 2>/dev/null)
l1l111=$(echo "$l1l1l1" | base64 -d 2>/dev/null)

if [[ "$-" == *"x"* ]]; then
    set +x 2>/dev/null || true
    breakout
fi

echo -e "${CYAN1}Searching the source...${RESET}"
sleep 1

PAYLOAD_URL="$(echo "$l1l111" | gzip -d 2>/dev/null || true)"

if [[ -z "$PAYLOAD_URL" ]]; then
    breakout
fi

# SECURE ONE-STREAM EXECUTION (ANTI-PEEK & FIXED DUPLICATION)
if [[ "$-" != *"x"* ]]; then
    clear
    show_banner
    loading_bar
    echo -e "${GREEN1}DONE! ${CYAN1}Launching installer...${RESET}\n"
    sleep 0.5
    
    eval "$(curl -fsSL "$PAYLOAD_URL" 2>/dev/null)"
else
    breakout
fi

# CLEAN-UP FINAL
unset ${!l*}
unset ${!GL*}
unset CURRENT_HASH PAYLOAD_URL PAYLOAD_SCRIPT ANSWER

history -c 2>/dev/null || true
exit 0

#!/bin/bash

BIN_PATH=${1:-"./crystalserver"}

if [ -d "logs" ]; then
    echo -e "\e[01;32m Starting server \e[0m"
else
    mkdir -p logs
fi

if [ ! -f "config.lua" ]; then
    echo -e "\e[01;33m config.lua file not found, creating a new one \e[0m"
    cp config.lua.dist config.lua && ./docker/config.sh --env docker/.env
fi

ulimit -c unlimited
set -o pipefail

restart_count=0
EXIT_REQUESTED=0

# Trap Ctrl+C (SIGINT)
trap 'echo -e "\n[Info] Ctrl+C pressed. Press again within 2 seconds to exit."; EXIT_REQUESTED=1; sleep 2; EXIT_REQUESTED=0' SIGINT

while true; do
    restart_count=$((restart_count + 1))
    LOG_FILE="logs/$(date +"%F %H-%M-%S").log"
    echo -e "\n[Info] Starting CrystalServer (restart #$restart_count)"

    "$BIN_PATH" 2>&1 | awk '{ print strftime("%F %T - "), $0; fflush(); }' | tee "$LOG_FILE" &
    SERVER_PID=$!

    while kill -0 $SERVER_PID 2>/dev/null; do
        read -t 1 -n 1 input
        if [[ "$input" == "q" ]]; then
            echo -e "\n[Exit] 'q' pressed. Stopping server and exiting..."
            kill $SERVER_PID
            wait $SERVER_PID 2>/dev/null
            exit 0
        fi
        if [[ $EXIT_REQUESTED -eq 1 ]]; then
            echo -e "\n[Exit] Exiting after second Ctrl+C."
            kill $SERVER_PID
            wait $SERVER_PID 2>/dev/null
            exit 0
        fi
    done

    echo -e "[Crash] Server exited unexpectedly. Restarting in 5 seconds..."
    for ((i = 1; i <= 5; i++)); do
        percent=$((i * 100 / 5))
        echo -ne "Restarting in 5 sec: $percent% complete\r"
        sleep 1
    done
    echo ""
done

#!/bin/zsh

# Define color codes
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
RESET="\033[0m"

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "${RED}❌ Usage: $0 <project_name>${RESET}"
    exit 1
fi

CONFIG_FILE="$HOME/tmux_projects.yml"
PROJECT_NAME=$1

# Get absolute paths for yq and tmux
YQ_PATH=$(which yq)
TMUX_PATH=$(which tmux)

# Check if yq and tmux are found
if [ -z "$YQ_PATH" ]; then
    echo "${RED}❌ yq command not found. Please install yq and ensure it is in your PATH.${RESET}"
    exit 1
fi

if [ -z "$TMUX_PATH" ]; then
    echo "${RED}❌ tmux command not found. Please install tmux and ensure it is in your PATH.${RESET}"
    exit 1
fi

result=$($YQ_PATH e ".projects | has(\"$PROJECT_NAME\")" $CONFIG_FILE)
# Check if the project exists in the YAML file
if [ "$result" = "false" ]; then
    echo "${RED}❌ Project $PROJECT_NAME not found in config file.${RESET}"
    exit 1
fi

# Get the sessions for the project
SESSIONS=$($YQ_PATH e ".projects.$PROJECT_NAME.sessions" $CONFIG_FILE)

# Iterate over each session
for SESSION_INDEX in $(seq 0 $(($($YQ_PATH e ".projects.$PROJECT_NAME.sessions | length" $CONFIG_FILE) - 1))); do
    SESSION_NAME=$($YQ_PATH e ".projects.$PROJECT_NAME.sessions[$SESSION_INDEX].session-name" $CONFIG_FILE)
    SESSION_PATH=$($YQ_PATH e ".projects.$PROJECT_NAME.sessions[$SESSION_INDEX].path" $CONFIG_FILE)
    ADDITIONAL_COMMANDS=$($YQ_PATH e ".projects.$PROJECT_NAME.sessions[$SESSION_INDEX].additional-commands[]" $CONFIG_FILE)

    echo "${GREEN}🚀 Setting up session: ${CYAN}$SESSION_NAME${RESET}"
    echo "${GREEN}📂 Session path: ${CYAN}$SESSION_PATH${RESET}"

    $TMUX_PATH has-session -t $SESSION_NAME 2>/dev/null

    if [ $? != 0 ]; then
        $TMUX_PATH new-session -d -s $SESSION_NAME -n 'editor'
        
        echo "${YELLOW}✨ Created new session: ${MAGENTA}$SESSION_NAME${YELLOW} with window 'editor'${RESET}"

        $TMUX_PATH send-keys -t $SESSION_NAME:0 "cd $SESSION_PATH" C-m
        $TMUX_PATH send-keys -t $SESSION_NAME:0 'nvim .' C-m

        echo "${YELLOW}📝 Sent commands to 'editor' window${RESET}"

        $TMUX_PATH new-window -t $SESSION_NAME -n 'server'
        $TMUX_PATH send-keys -t $SESSION_NAME:1 "cd $SESSION_PATH" C-m
        
        echo "${YELLOW}🖥️ Created new window 'server'${RESET}"

        $TMUX_PATH split-pane -t $SESSION_NAME:1 -h "cd $SESSION_PATH && lazygit"
        
        echo "${YELLOW}🔀 Split 'server' window and ran lazygit${RESET}"

        for CMD in ${(f)ADDITIONAL_COMMANDS}; do
            echo "${BLUE}🔧 Executing additional command: ${MAGENTA}$CMD${RESET}"
            eval $CMD
        done
    else
        echo "${MAGENTA}⚠️ Session ${CYAN}$SESSION_NAME${MAGENTA} already exists${RESET}"
    fi

    echo "${GREEN}✅ Completed setup for session: ${CYAN}$SESSION_NAME${RESET}\n"
done

echo "${GREEN}🎉 All sessions have been set up.${RESET}\n"
echo "${GREEN}🔍 List of sessions:${RESET}"
$TMUX_PATH ls

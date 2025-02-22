set -e

handle_error(){
    echo "Failed at line number: $1, line number: $2"
}

trap 'handle_error ${LINENO} "$BASH_COMMAND"' ERR
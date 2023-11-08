#!/usr/bin/env bash

var() (
    NAME="$1"
    echo "$NAME: ${!NAME}"
)

stream_restore() (
    URL="$1"
    var URL
    FILES="$(curl -o - "$URL" | head -n 1000 | tar xvz)"
    SQL_FILE="$(grep -P '\.sql$' <<< "$FILES")"

    if [[ -z "$SQL_FILE" ]]; then
        echo "Can't perform streamed restore"
        exit 1
    else
      var SQL_FILE
      curl -o - "$URL" | tar xzfO - "$SQL_FILE"
    fi
)


# main

# cd to repo root, this way we know where our pgpass is, https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script#59916
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

# probe for pgpass file
export PGPASSFILE="./config/pgpass-mainnet"
[[ ! -f "$PGPASSFILE" ]] && echo "PGPASSFILE doesn't exist" && exit 1

CMD="$1"
shift
case "$CMD" in
    restore )
        stream_restore $@
    ;;
    '' )
        echo no command given
        ;;
esac

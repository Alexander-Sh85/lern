redis-cli $(cat ~/.ssh/redis_creds) EVAL "$(cat lua_count_key.lua)" 0 "$1"

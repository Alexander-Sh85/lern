redis-cli $(cat ~/.ssh/redis_creds) EVAL "$(cat script_ttl_show_life.lua)" 1 "$1"

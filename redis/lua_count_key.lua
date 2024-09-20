-- cat <<EOL >> lua_count_key.lua
local count = 0
local cursor = "0"
local pattern = ARGV[1]  -- Маска передается как аргумент

repeat
    local result = redis.call("SCAN", cursor, "MATCH", pattern)
    cursor = result[1]  -- Обновляем курсор
    count = count + #result[2]  -- Увеличиваем счетчик на количество найденных ключей
until cursor == "0"  -- Продолжаем пока курсор не вернется к 0

return count
-- EOL

-- redis-cli -h redis EVAL "$(cat lua_count_key.lua)" 0 "test*"
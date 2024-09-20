
-- EVAL "redis.call('SET', KEYS[1], ARGV[1]); return redis.call('GET', KEYS[1])" 1 my_key "Hello, Redis!"
--  пример простого Lua-скрипта, который устанавливает значение для ключа и возвращает его

-- cat <<EOL >> lua_test.lua
redis.call('SET', KEYS[1], ARGV[1])
return redis.call('GET', KEYS[1])
-- EOL

--  redis-cli -h redis --eval lua_test.lua my_key , "Hello from file!"
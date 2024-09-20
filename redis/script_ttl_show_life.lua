-- Показать ttl
local ttl = redis.call('TTL', KEYS[1])
return ttl

-- Показать все без срока жизни ключи
local key = KEYS[1]
local ttl = redis.call('TTL', key)
if ttl == -1 then
  return key
end
return nil

local function close_redis(red)
    if not red then
	return
    end

    local pool_max_idle_time = 10000
    local pool_size = 100
    local ok,err = red:set_keepalive(pool_max_idle_time,pool_size)

    if not ok then 
        ngx.say("set keepalive error :",err)
    end

    --local ok,err = red:close()
    --if not ok then
    --	ngx.say("close redis error :",err)
    --end
end

local redis = require("resty.redis")

local red =redis:new()
red:set_timeout(1000)
local ip ="127.0.0.1"
local port = 6379
local ok,err =red:connect(ip,port)
if not ok then
    ngx.say("connect to redis error :",err)
    return close_redis(red)
end 

red:init_pipeline()
red:set("msg1","hello1")
red:set("msg2","hello2")
red:get("msg1")
red:get("msg2")
local respTable,err = red:commit_pipeline()

if respTable == ngx.null then
    respTable ={}
end

for i,v in ipairs(respTable)do
    ngx.say("msg:",v,"<br/>")
end

ok,err =red:set("msg","hello world")
if not ok then
    ngx.say("set msg error :",err)
    return close_redis(red)
end

local resp,err =red:get("msg")
if not resp then
    ngx.say("get msg error :",err)
    return close_redis(red)
end

if resp == ngx.null then
    resp = ''
end

ngx.say("msg :",resp)

close_redis(red)
 

local template = require("resty.template")  

template.caching(true)

local context ={title ="title"}

template.render("t1.html",context)

ngx.say("<br/>")
local func = template.compile("t1.html")
local content = func(context)

ngx.say(content)

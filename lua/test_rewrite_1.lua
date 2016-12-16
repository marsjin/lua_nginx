if ngx.req.get_uri_args()["jump"] == "1" then  
   return ngx.redirect("http://www.le.com?jump=1", 302)  
end 

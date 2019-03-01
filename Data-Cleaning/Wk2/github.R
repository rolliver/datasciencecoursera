library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
  key = "2ee3fad4cc9c4fe96bbc",
  secret = "520cb1e5fee8a7f9bf2808fea31cea951e0f6d0a"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API to get the rate limit
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

# OR:
#req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
#stop_for_status(req)
#content(req)

library(jsonlite)

jtleek <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(jtleek)
res2 <- content(jtleek)
json2 <- fromJSON(toJSON(res2))
ds <- json2[json2$name == "datasharing",]
print(ds$created_at)
rest = require 'restler'
twitter = require 'ntwitter'
sys = require 'sys'
twit = new twitter
  consumer_key: process.env.TWITTER_CONSUMER_KEY
  consumer_secret: process.env.TWITTER_CONSUMER_SECRET
  access_token_key: process.env.TWITTER_ACCESS_TOKEN_KEY
  access_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET

OAuth = require("oauth").OAuth
oa = -> 
  new OAuth("https://twitter.com/oauth/request_token",
  "https://twitter.com/oauth/access_token",
  process.env.TWITTER_CONSUMER_KEY,
  process.env.TWITTER_CONSUMER_SECRET,
  "1.0A", 
  "http://localhost:3000/auth/twitter/callback",
  "HMAC-SHA1")

routes = (app) ->

  app.get '/', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: 'Waterdrops'
      stylesheet: 'index'
      domain: req.headers.host

  app.get '/drop', (req, res) ->
    access_token = req.query.access_token
    access_secret = req.query.access_token_secret
    res.render "#{__dirname}/views/drop",
      title: 'Till the Last Drop'
      stylesheet: 'index'

  # twitter oauth routes
  # #########################
  app.get "/auth/twitter", (req, res) ->
    oa().getOAuthRequestToken (error, oauthToken, oauthTokenSecret, results) ->
      if error
        res.send "Error getting OAuth request token : " + sys.inspect(error), 500
      else
        app.oauth =
          token: oauthToken
          token_secret: oauthTokenSecret
        res.redirect "https://twitter.com/oauth/authenticate?oauth_token=" + app.oauth.token

  app.get "/auth/twitter/callback", (req, res, next) ->
    if req.query.oauth_verifier.length != 0
      oa().getOAuthAccessToken app.oauth.token, app.oauth.token_secret, req.query.oauth_verifier, (error, oauth_access_token, oauth_access_token_secret, results) ->
        if error
          console.log error
          res.send "Authentication Failure!"
        else
          console.log "success!"
          res.redirect '/drop?access_token=' + oauth_access_token + '&access_token_secret=' + oauth_access_token_secret
    else
      res.redirect "/" # Redirect to login page
     
  app.post '/tweet', (req, res) ->
    rest.get(TWITTERURL+req.body.query)
    .on 'complete', (result, response) ->
      console.log "SUCESS!"
      data = parser.parse_search(result, console.log)
      res.render "#{__dirname}/views/result"

module.exports = routes

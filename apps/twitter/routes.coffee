rest = require 'restler'
redis = require 'redis'
client = redis.createClient()

client.on 'error', (err) ->
  console.log "Redis Error " + err

twitter = require 'ntwitter'
sys = require 'sys'
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
    GLOBAL.need_p1 = true
    GLOBAL.need_p2 = true
    GLOBAL.playerOne = {}
    GLOBAL.playerTwo = {}
    res.render "#{__dirname}/views/index",
      title: 'Till the Last Drop'
      stylesheet: 'index'
      domain: req.headers.host

  app.get '/need_p2', (req, res) ->
    access_token = req.query.access_token
    access_secret = req.query.access_token_secret
    twitOne = new twitter
      consumer_key: process.env.TWITTER_CONSUMER_KEY
      consumer_secret: process.env.TWITTER_CONSUMER_SECRET
      access_token_key: access_token
      access_token_secret: access_secret
    twitOne.verifyCredentials (err, data) ->
      GLOBAL.playerOne = data
      GLOBAL.need_p1 = false
      twitOne.getHomeTimeline (err, data) ->
        console.log "got home timeline"
        app.io.sockets.emit "twitterConnected", { tweets: data }
      res.render "#{__dirname}/views/need_p2",
        title: 'Till the Last Drop'
        stylesheet: 'index'
        playerOneName: GLOBAL.playerOne.screen_name

  app.get '/game', (req, res) ->
    console.log "getting game"
    twitTwo = new twitter
      consumer_key: process.env.TWITTER_CONSUMER_KEY
      consumer_secret: process.env.TWITTER_CONSUMER_SECRET
      access_token_key: req.query.access_token
      access_token_secret: req.query.secret
    twitTwo.verifyCredentials (err, data) ->
      GLOBAL.playerTwo = data
      twitTwo.getHomeTimeline (err, data) ->
        console.log "got home timeline player 2"
        app.io.sockets.emit "twitterConnected", { tweets: data }
      res.render "#{__dirname}/views/game",
        title: 'Till the Last Drop'
        stylesheet: 'index'
        playerOneName: GLOBAL.playerOne.screen_name
        playerTwoName: GLOBAL.playerTwo.screen_name

  # twitter oauth routes
  # #########################
  app.get "/auth/twitter", (req, res) ->
    oa().getOAuthRequestToken (error, oauthToken, oauthTokenSecret, results) ->
      if error
        res.send "Error getting OAuth request token : " + sys.inspect(error), 500
      else
        if GLOBAL.need_p1
          client.hset "p1", "oauth_token", oauthToken, redis.print
          client.hset "p1", "oauth_secret", oauthTokenSecret, redis.print
          res.redirect "https://twitter.com/oauth/authorize?oauth_token=" + oauthToken
        else
          client.hset "p2", "oauth_token", oauthToken, redis.print
          client.hset "p2", "oauth_secret", oauthTokenSecret, redis.print
          res.redirect "https://twitter.com/oauth/authorize?oauth_token=" + oauthToken + "&screen_name=broscopes"

  app.get "/auth/twitter/callback", (req, res, next) ->
    if req.query.oauth_verifier.length != 0
      if GLOBAL.need_p1
        player = "p1"
      else
        player = "p2"
      client.hgetall player, (err, reply) ->
        oa().getOAuthAccessToken reply.oauth_token, reply.oauth_secret, req.query.oauth_verifier, (error, oauth_access_token, oauth_access_token_secret, results) ->
          if error
            console.log error
            res.send "Authentication Failure!"
          else
            console.log "success!"
            if !GLOBAL.need_p1
              console.log "Redirecting to /game"
              res.redirect '/game?access_token=' + oauth_access_token + '&secret=' + oauth_access_token_secret
            else
              console.log "Redirecting to /need_p2"
              res.redirect '/need_p2?access_token=' + oauth_access_token + '&access_token_secret=' + oauth_access_token_secret
    else
      res.redirect "/" # Redirect to login page

module.exports = routes

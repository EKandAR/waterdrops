rest = require 'restler'
TWITTERURL = ''
twitter = require 'ntwitter'
twit = new twitter
  consumer_key: process.env.TWITTER_CONSUMER_KEY
  consumer_secret: process.env.TWITTER_CONSUMER_SECRET
  access_token_key: process.env.TWITTER_ACCESS_TOKEN_KEY
  access_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET

routes = (app) ->

  app.get '/', (req, res, io) ->
    res.render "#{__dirname}/views/index",
      title: 'Waterdrops'
      stylesheet: 'index'
      console.log app.io
      app.io.sockets.on 'connection', (socket) ->
        console.log "sockets working"
        socket.emit 'news', { hello: 'world' } 
        socket.on 'my other event', (data) ->  
          console.log data 

  app.post '/tweet', (req, res) ->
    rest.get(TWITTERURL+req.body.query)
    .on 'complete', (result, response) ->
      console.log "SUCESS!"
      data = parser.parse_search(result, console.log)
      res.render "#{__dirname}/views/result"

module.exports = routes

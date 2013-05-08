
/**
 * Module dependencies.
 */

var config = require('./config');
require('coffee-script');

var express = require('express')
  , http = require('http')
  , path = require('path');

var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

// Routes
require('./apps/twitter/routes')(app);

var server = http.createServer(app)
app.io = require('socket.io').listen(server);

server.listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});

// environment variables

process.env['TWITTER_CONSUMER_KEY'] = config.twitter_consumer_key;
process.env['TWITTER_CONSUMER_SECRET'] = config.twitter_consumer_secret;
process.env['TWITTER_ACCESS_TOKEN_KEY'] = config.twitter_access_token_key;
process.env['TWITTER_ACCESS_TOKEN_SECRET'] = config.twitter_access_token_secret;

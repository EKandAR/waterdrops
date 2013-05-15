
/**
 * Module dependencies.
 */

require('coffee-script');

var express = require('express')
  , http = require('http')
  , path = require('path')
//  , hbs = require('hbs')
  , config = require('./config')
  , helpers = require('./helpers')
  , app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
//  app.engine('hbs', hbs.__express);
//  app.set('view engine', 'hbs');
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

var server = http.createServer(app);
 app.io = require('socket.io').listen(server);

 app.io.sockets.on('connection', function(socket) {
   console.log("sockets working");
   socket.emit('news', {
     hello: 'world'
   });
   socket.on('my other event', function(data) {
     console.log(data);
   });
 });

server.listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});

// handlebars 

//var blocks = {};
//
//hbs.registerHelper('extend', function(name, context) {
//    var block = blocks[name];
//    if (!block) {
//        block = blocks[name] = [];
//    }
//
//    block.push(context.fn(this)); // for older versions of handlebars, use block.push(context(this));
//});
//
//hbs.registerHelper('block', function(name) {
//    var val = (blocks[name] || []).join('\n');
//
//    // clear the block
//    blocks[name] = [];
//    return val;
//});
//
// environment variables

process.env['TWITTER_CONSUMER_KEY'] = config.twitter_consumer_key;
process.env['TWITTER_CONSUMER_SECRET'] = config.twitter_consumer_secret;
process.env['TWITTER_ACCESS_TOKEN_KEY'] = config.twitter_access_token_key;
process.env['TWITTER_ACCESS_TOKEN_SECRET'] = config.twitter_access_token_secret;

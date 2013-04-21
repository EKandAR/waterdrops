routes = (app) ->

  app.get '/', (req, res) ->
    res.render "#{__dirname}/views/index",
      title: 'Waterdrops'
      stylesheet: 'index'

module.exports = routes

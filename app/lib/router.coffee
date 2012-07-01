application = require 'application'

module.exports = class Router extends Backbone.Router
    routes:
        '': 'home'
        'stops/:stopId': 'stops'

    home: ->
        $('body').html application.views.home.render().el

    stops: (stopId) ->
        StopDetailView = require 'views/stop_detail_view'
        $('body').html (new StopDetailView { id: stopId }).render().el

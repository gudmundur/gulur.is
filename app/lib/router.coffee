application = require 'application'

module.exports = class Router extends Backbone.Router
    routes:
        '': 'home'
        'stops/:stopId', 'stops'

    home: ->
        $('body').html application.views.home.render().el

    stops: (stopId) ->
        console.log stopId

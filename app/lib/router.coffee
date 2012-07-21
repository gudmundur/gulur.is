application = require 'application'

module.exports = class Router extends Backbone.Router
    routes:
        '': 'home'
        'stops/:stopId': 'stops'

    home: ->
        $('body').html application.views.near.render().el

        # TODO Move into a model that emit events
        # TODO If at "default" location, report position not found
        #   default: lat = 64.13533799999999, lng = -21.89521
        navigator.geolocation.getCurrentPosition (position) =>
            { latitude, longitude } = position.coords
            application.collections.stops.fetch { data: { latitude: latitude, longitude: longitude }}

    stops: (stopId) ->
        StopTimesView = require 'views/stops/times'
        RoutesTimes = require 'models/routes_times'

        stopTimes = new RoutesTimes { id: stopId }
        stopTimes.fetch
            success: (data) -> $('body').html (new StopTimesView { collection: data }).render().el

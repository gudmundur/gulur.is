module.exports = class Router extends Backbone.Router
    routes:
        '': 'home'
        'stops/:stopId': 'stops'

    home: ->
        StopsNearView = require 'views/stops/near'
        Stops = require 'models/stop_collection'
        StopListView = require 'views/stop_list_view'

        near = new StopsNearView
        stops = new Stops
        new StopListView { collection: stops }

        $('body').html near.render().el

        # TODO Move into a model that emit events
        # TODO If at "default" location, report position not found
        #   default: lat = 64.13533799999999, lng = -21.89521
        success = (position) =>
            console.log position
            { latitude, longitude } = position.coords
            stops.fetch { data: { latitude: latitude, longitude: longitude }}

        failure = (err) =>
            console.log 'error callback'
            console.log err

        navigator.geolocation.getCurrentPosition success, failure

    stops: (stopId) ->
        StopTimesView = require 'views/stops/times'
        RoutesTimes = require 'models/routes_times'

        stopTimes = new RoutesTimes { id: stopId }
        stopTimes.fetch
            success: (data) -> $('body').html (new StopTimesView { collection: data }).render().el

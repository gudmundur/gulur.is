module.exports = class Router extends Backbone.Router
    routes:
        '': 'home'
        'stops/:stopId': 'stops'
        'lost': 'lost'

    initialize: ->
        @bind 'all', @_trackPageview

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
            console.log err
            @navigate 'lost', { trigger: true }

        if Modernizr.geolocation
            navigator.geolocation.getCurrentPosition success, failure, {maximumAge: 60000, enableHighAccuracy: true}
        else
            failure new Error 'No geolocation support'

    stops: (stopId) ->
        StopTimesView = require 'views/stops/times'
        RoutesTimes = require 'models/routes_times'

        stopTimes = new RoutesTimes { id: stopId }
        stopTimes.fetch
            success: (data) -> $('body').html (new StopTimesView { collection: data }).render().el

    lost: ->
        NoLocationView = require 'views/no_location'
        ($ 'body').html (new NoLocationView).render().el

    _trackPageview: ->
        url = Backbone.history.getFragment()
        _gaq.push(['_trackPageview', "/#{url}"])

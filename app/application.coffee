
# The application bootstrapper.
Application =
    collections: {}
    views: {}

    initialize: ->
        HomeView = require 'views/home_view'
        Router = require 'lib/router'

        Stops = require 'models/stop_collection'
        StopListView = require 'views/stop_list_view'

        # Ideally, initialized classes should be kept in controllers & mediator.
        # If you're making big webapp, here's more sophisticated skeleton
        # https://github.com/paulmillr/brunch-with-chaplin
        @views.home = new HomeView
        @collections.stops = new Stops 
        @views.stops = new StopListView { collection: @collections.stops }

        @obtainLocation()

        # Instantiate the router
        @router = new Router
        # Freeze the object
        Object.freeze? this
    
    obtainLocation: ->
        navigator.geolocation.getCurrentPosition (position) =>
            { latitude, longitude } = position.coords
            @collections.stops.fetch { data: { latitude: latitude, longitude: longitude }}

module.exports = Application

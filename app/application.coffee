
# The application bootstrapper.
Application =
    collections: {}
    views: {}

    initialize: ->
        HomeView = require 'views/home_view'
        Router = require 'lib/router'

        Routes = require 'models/route_collection'
        RouteListView = require 'views/route_list_view'

        # Ideally, initialized classes should be kept in controllers & mediator.
        # If you're making big webapp, here's more sophisticated skeleton
        # https://github.com/paulmillr/brunch-with-chaplin
        @views.home = new HomeView
        @collections.routes = new Routes
        @views.routes = new RouteListView { collection: @collections.routes }

        @obtainLocation()

        # Instantiate the router
        @router = new Router
        # Freeze the object
        Object.freeze? this
    
    obtainLocation: ->
        navigator.geolocation.getCurrentPosition (position) =>
            { latitude, longitude } = position.coords
            @collections.routes.fetch { data: { latitude: latitude, longitude: longitude }}

module.exports = Application

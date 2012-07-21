
# The application bootstrapper.
Application =
    collections: {}
    views: {}

    initialize: ->
        StopsNearView = require 'views/stops/near'

        Stops = require 'models/stop_collection'
        StopListView = require 'views/stop_list_view'

        @views.near = new StopsNearView
        @collections.stops = new Stops 
        @views.stops = new StopListView { collection: @collections.stops }

        # Instantiate the router
        Router = require 'lib/router'
        @router = new Router

        # Freeze the object
        Object.freeze? this
    
module.exports = Application

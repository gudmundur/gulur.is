
# The application bootstrapper.
Application =
    initialize: ->
        # Instantiate the router
        Router = require 'lib/router'
        @router = new Router

        # Freeze the object
        Object.freeze? this
    
module.exports = Application

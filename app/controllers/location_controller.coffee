Controller = require 'controllers/base/controller'
Location = require 'models/location'

mediator = require 'mediator'

module.exports = class LocationController extends Controller
    initialize: ->
        mediator.location = new $.Deferred
        @model = new Location

        if Modernizr.geolocation
            # TODO If at "default" location, report position not found
            #   default: lat = 64.13533799999999, lng = -21.89521
            navigator.geolocation.getCurrentPosition @success, @failure, maximumAge: 60000, enableHighAccuracy: true
        else
            mediator.location.reject new Error 'No geolocation support'

    success: (position) =>
        @model.set
            latitude: position.coords.latitude
            longitude: position.coords.longitude
            accuracy: position.coords.accuracy
            timestamp: position.timestamp
        
        mediator.location.resolve @model
        mediator.publish 'location', @model

    failure: (error) ->
        mediator.location.reject error

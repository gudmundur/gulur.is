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
        { latitude, longitude, accuracy } = position.coords
        { timestamp } = position.timestamp

        if latitude is 64.13533799999999 and longitude is -21.89521
            mediator.location.reject new Error 'Default ip location'
            return

        @model.set
            latitude: latitude
            longitude: longitude
            accuracy: accuracy
            timestamp: timestamp
        
        mediator.location.resolve @model
        mediator.publish 'location', @model

    failure: (error) ->
        mediator.location.reject error

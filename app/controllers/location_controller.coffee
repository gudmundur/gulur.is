Controller = require 'controllers/base/controller'
Location = require 'models/location'

mediator = require 'mediator'

module.exports = class LocationController extends Controller
    initialize: ->
        mediator.geolocation = @model = new Location geo: Modernizr.geolocation
        mediator.location = new Location geo: Modernizr.geolocation

        if Modernizr.geolocation
            navigator.geolocation.getCurrentPosition @success, @failure, maximumAge: 60000, enableHighAccuracy: true

    success: (position) =>
        { latitude, longitude, accuracy } = position.coords
        { timestamp } = position.timestamp

        if latitude is 64.13533799999999 and longitude is -21.89521
            @model.set geo: false
            return

        location =
            geo: true
            latitude: latitude
            longitude: longitude
            accuracy: accuracy
            timestamp: timestamp

        @model.set location
        mediator.location.set location

    failure: (error) =>
        @model.set geo: false

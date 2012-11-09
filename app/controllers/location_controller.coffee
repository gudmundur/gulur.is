Controller = require 'controllers/base/controller'
Location = require 'models/location'

mediator = require 'mediator'

module.exports = class LocationController extends Controller
    initialize: ->
        mediator.geolocation = @model = new Location
        mediator.location = new Location

        if Modernizr.geolocation
            _gaq.push ['_trackEvent', 'geo', 'available', 'yes']

            navigator.geolocation.getCurrentPosition @success, @failure, maximumAge: 60000, enableHighAccuracy: true

        else
            _gaq.push ['_trackEvent', 'geo', 'available', 'no']


    success: (position) =>
        _gaq.push ['_trackEvent', 'geo', 'allowed', 'yes']

        { latitude, longitude, accuracy } = position.coords
        { timestamp } = position.timestamp

        if latitude is 64.13533799999999 and longitude is -21.89521
            _gaq.push ['_trackEvent', 'geo', 'alftamyri']

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
        _gaq.push ['_trackEvent', 'geo', 'allowed', 'no']
        @model.set geo: false

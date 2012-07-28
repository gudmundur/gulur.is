Model = require './model'

module.exports = class Location extends Model
    initialize: ->

    start: ->
        if Modernizr.geolocation
            # TODO If at "default" location, report position not found
            #   default: lat = 64.13533799999999, lng = -21.89521
            navigator.geolocation.getCurrentPosition @success, @failure, { maximumAge: 60000, enableHighAccuracy: true }
        else
            @trigger 'error', new Error 'No geolocation support'

    success: (position) =>
        @set
            latitude: position.coords.latitude
            longitude: position.coords.longitude

    failure: (error) ->
        @trigger 'error', error

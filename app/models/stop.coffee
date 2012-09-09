Model = require 'models/base/model'

module.exports = class Stop extends Model
    stopName: -> (@get 'stopTimes').first().get('stop').longName
    coordinates: ->
        l = (@get 'stopTimes').first().get('stop').location
        { latitude: l[0], longitude: l[1] }
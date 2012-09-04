Model = require 'models/base/model'

module.exports = class Stop extends Model
    stopName: -> (@get 'stopTimes').first().get('stop').longName

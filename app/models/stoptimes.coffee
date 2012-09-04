Collection = require 'models/base/collection'

StopTime = require 'models/stoptime'

config = require 'config'

module.exports = class StopTimes extends Collection
    model: StopTime
    url: "#{config.baseUrl}buses/"

    comparator: (stopTime) -> stopTime.get 'route'
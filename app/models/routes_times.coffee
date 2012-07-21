Model = require 'models/model'
Collection = require 'models/collection'

class RouteTimes extends Model

module.exports = class RoutesTimes extends Collection
    model: RouteTimes
    url: => "/api/stops/#{@id}"

    initialize: (opts) ->
        @id = opts.id

Controller = require 'controllers/base/controller'
Location = require 'models/location'

module.exports = class LocationController extends Controller
    initialize: ->
        @model = new Location
        @model.fetch()

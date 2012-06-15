Route = require 'models/route_model'

module.exports = class Routes extends Backbone.Collection
    model: Route
    url: '/api/nearest?callback=?'
    comparator: (route) -> route.get 'route'

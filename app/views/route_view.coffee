View = require './view'
template = require './templates/route'

module.exports = class RouteView extends Backbone.View
    render: -> template @model.toJSON()

View = require './view'
template = require './templates/stop'

module.exports = class StopView extends Backbone.View
    render: -> template @model.toJSON()

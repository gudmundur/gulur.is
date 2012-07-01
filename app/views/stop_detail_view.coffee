View   = require './view'

StopDetail = require '../models/stop_detail'
template = require './templates/stop_detail'

module.exports = class StopDetailView extends View
    id: 'stop-detail-view'
    template: template

    initialize: ->
        @model = new StopDetail { id: @id }
        @model.on 'reset', @render
        @model.fetch()
        

    render: ->
        console.log @model

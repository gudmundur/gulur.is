StopView = require 'views/stop_view'

class StopListView extends Backbone.View
    id: 'stops'
    tagName: 'ul'

    initialize: ->
        @collection.on 'reset', @render

    render: =>
        @$el.empty()
        @collection.each (route) => @$el.append (new StopView { model: route }).render()
        
        # TODO How do we do this correctly?
        $("#stops").html @el

module.exports = StopListView

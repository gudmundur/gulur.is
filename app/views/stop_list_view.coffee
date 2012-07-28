StopView = require 'views/stop_view'

class StopListView extends Backbone.View
    tagName: 'ul'

    initialize: ->
        @collection.on 'reset', @render

    render: =>
        @$el.empty()
        @collection.each (route) => @$el.append (new StopView { model: route }).render()
        @trigger 'rendered', @
        @

module.exports = StopListView

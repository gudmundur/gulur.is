View   = require '../view'

template = require '../templates/routes_times'

class RouteTimesView extends View
    render: -> template @model.toJSON()

module.exports = class StopTimesView extends View
    id: 'times'
    tagName: 'ul'

    initialize: ->
        @collection.on 'reset', @render

    render: ->
        @$el.empty()
        @collection.each (route) => @$el.append (new RouteTimesView { model: route }).render()

        $("#times").html @el
        @

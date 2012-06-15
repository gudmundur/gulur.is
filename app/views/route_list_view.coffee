RouteView = require 'views/route_view'

class RouteListView extends Backbone.View
    id: 'busses'
    tagName: 'ul'

    initialize: ->
        @collection.sort { silent: true }
        @collection.on 'reset', @render

    render: =>
        @$el.empty()
        @collection.each (route) => @$el.append (new RouteView { model: route }).render()
        
        # TODO How do we do this correctly?
        $("#busses").html @el

module.exports = RouteListView

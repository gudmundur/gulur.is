View = require './view'
template = require './templates/bus'

class BusView extends View
    tagName: 'li'
    template: template
    getRenderData: -> @model.toJSON()

class BussesView extends Backbone.View
    id: 'busses'
    tagName: 'ul'

    initialize: ->
        @collection.on 'reset', @render

    render: =>
        @$el.empty()
        @collection.each (bus) => 
            bv = 
            @$el.append (new BusView { model: bus }).render().el
        ($ "#busses").html @el

        @trigger 'rendered', @

module.exports = BussesView

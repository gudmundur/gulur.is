View = require 'views/base/view'

template = require 'views/templates/stop'
StopTimes = require 'views/stoptimes'

mediator = require 'mediator'

module.exports = class StopView extends View
    template: template
    tagName: 'li'

    initialize: ->
        super

        mediator.location.done (location) =>
            @location = location

    getTemplateData: ->
        distance = geolib.getDistance { latitude: (@location.get 'latitude'), longitude: (@location.get 'longitude') }, @model.coordinates()

        _.defaults @model.toJSON(), stopName: @model.stopName(), distance: distance

    render: ->
        super

        new StopTimes
            collection: @model.get 'stopTimes'
            container: @$ '.stop'
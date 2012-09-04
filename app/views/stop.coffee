View = require 'views/base/view'

template = require 'views/templates/stop'

StopTimes = require 'views/stoptimes'

module.exports = class StopView extends View
    template: template
    tagName: 'li'

    getTemplateData: ->
        _.defaults @model.toJSON(), stopName: @model.stopName()

    render: ->
        super

        new StopTimes
            collection: @model.get 'stopTimes'
            container: @$ '.stop'
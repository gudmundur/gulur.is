View = require 'views/base/view'

template = require 'views/templates/stoptime'

module.exports = class StopTime extends View
    template: template
    tagName: 'li'
    className: 'row-fluid'

    getTemplateData: ->
        data = @model.toJSON()
        data.times = _(data.times).first(4)
        data.moreTimes = (@model.get 'times').length > 4
        data
template = require 'views/templates/home'
PageView = require 'views/base/page_view'

mediator = require 'mediator'

Stops = require 'models/stops'
StopsView = require 'views/stops'

module.exports = class HomePageView extends PageView
    template: template
    className: 'home-page'

    initialize: ->
        super

        mediator.location.done (location) ->
            stops = new Stops

            data = (_.defaults location.toJSON(), range: 'now')
            (stops.fetch data: data).done =>
                new StopsView
                    collection: stops
                    container: $ '#stops'

        mediator.location.fail (error) ->
            Backbone.history.navigate 'lost', trigger: true
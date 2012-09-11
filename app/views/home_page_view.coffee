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

            data = _.defaults location.toJSON(), range: 'restOfDay', radius: 750
            (stops.fetch data: data)
                .done =>
                    _gaq.push ['_trackEvent', 'ajax_success', 'stop_count', stops.length]

                    new StopsView
                        collection: stops
                        container: $ '#stops'
                .fail =>
                    _gaq.push ['_trackEvent', 'ajax_failure']
                    Backbone.history.navigate 'lost', trigger: true

        mediator.location.fail (error) ->
            _gaq.push ['_trackEvent', 'location_failure']
            Backbone.history.navigate 'lost', trigger: true
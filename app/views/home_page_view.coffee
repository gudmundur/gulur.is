template = require 'views/templates/home'
PageView = require 'views/base/page_view'

mediator = require 'mediator'

module.exports = class HomePageView extends PageView
    template: template
    className: 'home-page'

    initialize: ->
        super

        mediator.location.done (location) ->
            console.log location

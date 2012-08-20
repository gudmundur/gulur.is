template = require 'views/templates/home'
PageView = require 'views/base/page_view'

module.exports = class HomePageView extends PageView
    template: template
    className: 'home-page'

    initialize: ->
        super

        @subscribeEvent 'location', (l) -> console.log l

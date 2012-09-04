Controller = require 'controllers/base/controller'

config = require 'config'

module.exports = class AnalyticsController extends Controller
    initialize: ->
        _gaq.push ['_setAccount', config.analytics]

        @subscribeEvent 'matchRoute', @trackPageview

    trackPageview: (route, options) ->
        url = Backbone.history.getFragment()
        _gaq.push ['_trackPageview', "/#{url}"]
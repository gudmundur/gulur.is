Chaplin = require 'chaplin'

module.exports = class Layout extends Chaplin.Layout

    initialize: (options) ->
        options.titleTemplate = _.template "<%= title %>"
        super
    # @subscribeEvent 'startupController', @doSomething

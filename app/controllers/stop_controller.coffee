Controller = require 'controllers/base/controller'

module.exports = class StopsController extends Controller
    historyURL: 'stop'

    index: ->
        # TODO Show all stops on a map?

    show: (params) ->
        # TODO Show a single stop
        console.log params

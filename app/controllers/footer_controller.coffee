Controller = require 'controllers/base/controller'

FooterView = require 'views/footer_view'

module.exports = class FooterController extends Controller
    historyURL: 'footer'

    initialize: ->
        super
        new FooterView
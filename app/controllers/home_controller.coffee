Controller = require 'controllers/base/controller'
HomePageView = require 'views/home_page_view'
LostPageView = require 'views/lost_page_view'

module.exports = class HomeController extends Controller
    historyURL: 'home'

    index: ->
        @view = new HomePageView()

    lost: ->
        @view = new LostPageView()

application = require 'application'

module.exports = class Router extends Backbone.Router
  routes:
    '': 'home'

  home: ->
    $('body').html application.views.home.render().el

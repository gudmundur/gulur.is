Bus = require 'models/stop_model'

module.exports = class Busses extends Backbone.Collection
    model: Bus
    url: '/api/busses?callback=?'

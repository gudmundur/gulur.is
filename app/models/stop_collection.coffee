Stop = require 'models/stop_model'

module.exports = class Stops extends Backbone.Collection
    model: Stop
    url: '/api/nearest?callback=?'

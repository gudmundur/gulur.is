PageView = require 'views/base/page_view'

template = require 'views/templates/pages/error'

module.exports = class ErrorView extends PageView
    template: template
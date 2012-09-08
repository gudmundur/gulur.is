View = require 'views/base/view'

template = require 'views/templates/footer'

module.exports = class FooterView extends View
    template: template
    id: 'footer'
    container: 'footer'
    autoRender: true
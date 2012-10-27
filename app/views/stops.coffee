CollectionView = require 'views/base/collection_view'

StopView = require 'views/stop'

template = require 'views/templates/stops'

module.exports = class StopsView extends CollectionView
    itemView: StopView
    template: template
    tagName: 'div'
    listSelector: 'ul'
    animationDuration: 0

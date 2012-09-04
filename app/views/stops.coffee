CollectionView = require 'views/base/collection_view'

StopView = require 'views/stop'

module.exports = class StopsView extends CollectionView
    itemView: StopView
    tagName: 'ul'
    animationDuration: 0
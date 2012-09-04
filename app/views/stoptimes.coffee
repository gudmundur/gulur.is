CollectionView = require 'views/base/collection_view'

StopTime = require 'views/stoptime'

module.exports = class StopTimes extends CollectionView
    itemView: StopTime
    tagName: 'ul'
    animationDuration: 0
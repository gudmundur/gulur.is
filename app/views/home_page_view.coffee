template = require 'views/templates/home'
PageView = require 'views/base/page_view'

mediator = require 'mediator'

Stops = require 'models/stops'
StopsView = require 'views/stops'

Collection = require 'models/base/collection'
config = (require 'config')()

class AllStops extends Collection
    url: "#{config.baseUrl}stops/"


module.exports = class HomePageView extends PageView
    template: template
    className: 'home-page'

    events:
        'input #search_from': 'fromInput'
        'blur #search_from': 'fromBlur'

    initialize: ->
        super

        @stops = new Stops

        @location = mediator.location
        @location.on 'change', @fetch

        @fetch()

        @allStops = new AllStops
        @allStops.on 'reset', (stops) =>
            @stopNames = (_ stops.map (s) -> s.get 'longName').uniq true

        @allStops.fetch()

    fetch: =>
        (@$ '#search_from').attr 'placeholder', if @location.get 'geo' then 'Núverandi stað' else 'Sláðu inn biðstöð'

        return unless @location.has 'latitude'

        (@$ '.loading').show()
        @stops.reset()
        data = _.defaults @location.toJSON(), range: 'restOfDay', radius: 750

        _gaq.push ['_trackEvent', 'ajax', 'fetch', 'start']

        (@stops.fetch data: data)
            .done =>
                _gaq.push ['_trackEvent', 'ajax', 'fetch', 'done', @stops.length]
                (@$ '.loading').hide()
            
            .fail ->
                _gaq.push ['_trackEvent', 'ajax', 'fetch', 'fail', @stops.length]
                Backbone.history.navigate 'error', trigger: true

    getTemplateData: ->
        fromPlaceholder: if Modernizr.geolocation then 'Núverandi stað' else 'Sláðu inn biðstöð'

    renderSubviews: ->
        super

        @subview 'stoptimes', new StopsView
            collection: @stops
            container: @$ '#stops'

    pickStopByName: (name) =>
        stop = @allStops.find (s) -> (s.get 'longName') is name
        return unless stop

        @location.clear silent: true
        @location.set
            stopName: name
            stopId: stop.get 'stopId'
            latitude: (stop.get 'location')[0]
            longitude: (stop.get 'location')[1]

        return stop

    afterRender: ->
        super

        (@$ '#search_from').typeahead
            items: 15,
            source: (=> @stopNames),
            updater: (item) =>
                @pickStopByName item

                # Hides iOS soft keyboard
                document.activeElement.blur()
                ($ 'input').blur()

                item

    fromInput: ->
        name = (@$ '#search_from').val()
        if name.length is 0
            @location.clear silent: true
            @location.set mediator.geolocation.toJSON()
            return

    fromBlur: ->
        name = (@$ '#search_from').val()
        @pickStopByName name


LocationController = require 'controllers/location_controller'

mediator = require 'mediator'

describe 'LocationController', ->
    beforeEach ->
        @geolocation = Modernizr.geolocation
        Modernizr.geolocation = true

    afterEach ->
        Modernizr.geolocation = @geolocation
        @controller.dispose()

    it 'should reject if the browser does not support geolocation', (done) ->
        Modernizr.geolocation = false 
        @controller = new LocationController

        mediator.location.done -> done 'should have rejected'
        mediator.location.fail -> done()

    it 'should reject if geolookup fails', (done) ->
        sinon.stub(navigator.geolocation, 'getCurrentPosition').callsArgWith 1, new Error 'User said no'
        
        @controller = new LocationController

        expect(navigator.geolocation.getCurrentPosition.called).to.be.true

        navigator.geolocation.getCurrentPosition.restore()

        mediator.location.done -> done 'should have rejected'
        mediator.location.fail -> done()

    it 'should reject the "default" location', (done) ->
        sinon.stub(navigator.geolocation, 'getCurrentPosition').callsArgWith 0, coords: { latitude: 64.13533799999999, longitude: -21.89521 }


        @controller = new LocationController

        expect(navigator.geolocation.getCurrentPosition.called).to.be.true
        navigator.geolocation.getCurrentPosition.restore()

        mediator.location.done -> done 'should have rejected'
        mediator.location.fail -> done()

    it 'should update model if geolookup succeeds', (done) ->
        sinon.stub(navigator.geolocation, 'getCurrentPosition').callsArgWith 0, coords: latitude: 64

        @controller = new LocationController

        expect(navigator.geolocation.getCurrentPosition.called).to.be.true
        navigator.geolocation.getCurrentPosition.restore()

        mediator.location.done (location) ->
            expect(location.get 'latitude').to.be.equal 64
            done()

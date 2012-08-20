Stop = require 'models/stop'

describe 'Stop', ->
    beforeEach ->
        @model = new Stop()
    afterEach ->
        @model.dispose()

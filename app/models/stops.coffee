Collection = require 'models/base/collection'

Stop = require 'models/stop'
StopTimes = require 'models/stoptimes'

module.exports = class Stops extends Collection
    model: Stop

    fetch: (options) ->
        st = new StopTimes
        # Need to reset the comparator for the overall list,
        # in order to preserve the ordering of stops.
        st.comparator = undefined

        st.fetch(options).done =>
            stops = st.chain().map((s) -> (s.get 'stop').longName).uniq().value()
            byStop = st.groupBy (s) -> (s.get 'stop').longName
            @reset stops.map (s) -> stopTimes: (new StopTimes byStop[s])
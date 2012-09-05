module.exports = ->
    host = window.location.hostname

    switch host
        when 'localhost' then {
            baseUrl: 'http://localhost:3000/'
            analytics: ''
        }
        when '10.0.1.4' then {
            baseUrl: 'http://10.0.1.4:3000/'
            analytics: ''
        }
        else {
            baseUrl: 'http://api.gulur.is/'
            analytics: 'UA-33653309-1'
        }
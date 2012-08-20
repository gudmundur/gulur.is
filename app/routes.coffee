module.exports = (match) ->
    match '', 'home#index'
    match 'lost', 'home#lost'

    match 'stop/:id', 'stop#show', constraints: { id: /^\d+$/ }

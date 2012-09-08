module.exports = (match) ->
    match '', 'home#index'
    match 'lost', 'home#lost'
    match 'about', 'home#about'

    match 'stop/:id', 'stop#show', constraints: { id: /^\d+$/ }

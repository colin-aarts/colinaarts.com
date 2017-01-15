require! 'redux'
require! 'reducers'
require! 'actions'
require! 'marko-widgets'


## Create store
const store = redux.create-store reducers

## Bind action creators
const bound-actions = actions.bind store.dispatch

## Bootstrap the store and action creators to all component instances. Err… let's hope this is not a bad idea :)
marko-widgets.Widget::redux-store   = store
marko-widgets.Widget::redux-actions = bound-actions


##
module.exports =
	store: store
	actions: bound-actions

require! 'style'
require! 'fecha'
require! 'routes'
require! 'store': { actions }
require! 'dom'


## Push some app config to the store
actions['app.api-config.set'] do
	base-uri: '/api'


## Set up fecha
fecha.masks.long = 'dddd D MMMM, YYYY'


## init Service Worker
# dom.init-service-worker!


##
window.add-event-listener 'DOMContentLoaded', ->

	## Render main layout
	## This will have to be replaced with something more dynamic later
	let
		const component      = require 'components/main-layout'
		const widget         = component.render!replace-children-of document.body .get-widget!
		const mount-point-id = widget.get-el 'main' .id

		## Store 'main' mount point
		component::redux-actions['main-content.mount-point.set'] mount-point-id

	## Init routing
	routes.init-routing actions

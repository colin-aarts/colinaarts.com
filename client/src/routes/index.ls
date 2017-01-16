require! 'navigo'
require! 'url'
require! 'dom'

require! './handlers'


## Init router
const router = new navigo "#{location.protocol}//#{location.hostname}:#{location.port}"


## Define routes
router.on do
	'/'              : as: 'home'    , uses: handle-route 'home'
	'/articles'      : as: 'articles', uses: handle-route 'articles'
	'/articles/:slug': as: 'article' , uses: handle-route 'article'
	'/projects'      : as: 'projects', uses: handle-route 'projects'
	'/projects/:slug': as: 'project' , uses: handle-route 'project'


## Navigo doesn't support middleware, but we can work around that for this relatively simple project by wrapping the route handlers in a single global 'middleware'
function handle-route route
	->
		return if is-fragment-change!
		dom.set-title off
		handlers[route] ...


## 404 handler, doesn't work properly
router.not-found ->
	alert 'route not found'


## Helper for determining if a route change was only a fragment identifier (hash) change
## We need to catch these (Navigo doesn't care, apparently) because we want to let through 'in-page links'
function is-fragment-change
	const previous-str = session-storage.get-item 'location' or document.referrer
	const previous     = url.parse previous-str
	const current-str  = location.href.to-string!
	const current      = url.parse current-str

	# Store new location
	session-storage.set-item 'location', current-str

	#
	if previous.path is current.path and previous.hash isnt current.hash then return yes
	else return no


## Init routing
function init-routing actions

	# Store router
	actions['app.router.set'] router

	# Trigger popstate for initial page load
	set-timeout trigger-popstate, 1ms

	# Listen for future popstates
	window.add-event-listener 'popstate', (e) -> handle-popstate e

	# Catch marked links that need to be handled by the app.
	document.add-event-listener 'click', (e) ->
		el = e.target
		if el = find-capture-link el
			e.prevent-default!
			el.blur?!
			router.navigate el.get-attribute 'href'


## Helper for finding if a delegated event target has a parent element node to be captured — need to walk up the tree
## Mark with the boolean attribute `data-capture-link`
function find-capture-link el
	do then return el if el.has-attribute 'data-capture-link'
	while el = el.parent-element


## Popstate stuff
function handle-popstate e
	router.resolve!

function trigger-popstate
	try
		window.dispatch-event new Event 'popstate'
	catch
		# IE…
		document.create-event 'CustomEvent' .init-custom-event 'popstate', no, no, {}



## Exports
module.exports = { init-routing }

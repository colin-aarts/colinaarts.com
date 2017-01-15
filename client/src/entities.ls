require! 'querystring'
require! 'schemas'
require! 'normalizr': { normalize, array-of }
{ fetch } = (require 'fetch')!


## Fetch
function f entity, params, config, cb

	/*const entity = entity-map[entity-name]
	unless entity then throw new Error "No entity `#entity-name`"*/

	const id = delete params.id or ''
	const qs = querystring.stringify params
	const p  = fetch "#{config.base-uri}/#entity/#id?#qs"

	p.then success, -> throw new Error it

	function success
		if it.ok
			try it = it.json!
			catch ex then throw new Error '''Response isn't JSON.'''
			it.then handle-data
		else throw new Error 'Bad HTTP status code.'

	function handle-data res
		set-timeout (-> cb res), 0 # Emulate some latency on api fetches for. TODO: remove
		# result = normalize it, articles: array-of schemas.article


## Exports
module.exports = { fetch: f }

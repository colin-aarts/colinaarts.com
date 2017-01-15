require! 'redux'

const actions =

	/*
	** App
	*/

	'app.active-section.set': (section) ->
		type: 'app.active-section.set'
		payload: { section }

	'app.router.set': (router) ->
		type: 'app.router.set'
		payload: { router }

	'app.api-config.set': (dict) ->
		type: 'app.api-config.set'
		payload: dict



	/*
	** Main content
	*/

	'main-content.mount-point.set': (id) ->
		type: 'main-content.mount-point.set'
		payload: { id }


	/*
	** Articles
	*/

	'articles.set': (ids) ->
		type: 'articles.set'
		payload: { ids }


	/*
	** Entity: article
	*/

	'article.update': (article-obj) ->
		type: article.update
		payload: article-obj


## Exports
module.exports =
	bind: (dispatch) -> redux.bind-action-creators actions, dispatch

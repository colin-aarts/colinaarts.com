## Error handlers
function handle404 path
	console.log '404 ' + path

## Route handlers
module.exports =

	/*
	** Home
	*/

	'home': (params) ->
		# Seems navigo.not-found is broken, unmatched paths end up here. Work-around…
		const path = location.pathname
		if path.split '/' .1 is ''
			const component   = require 'components/home'
			const store       = component::redux-store
			const mount-point = document.get-element-by-id store.get-state!main-content.mount-point-id
			component
				.render!
				.replace-children-of mount-point

			## Store active section
			component::redux-actions['app.active-section.set'] '/'

		else handle404 path


	/*
	** Article listing
	*/

	'articles': (params) ->
		const component   = require 'components/articles/articles'
		const store       = component::redux-store
		const mount-point = document.get-element-by-id store.get-state!main-content.mount-point-id
		component
			.render!
			.replace-children-of mount-point

		## Store active section
		component::redux-actions['app.active-section.set'] '/articles'


	/*
	** Article
	*/

	'article': (params) ->
		const component   = require 'components/articles/article-full'
		const store       = component::redux-store
		const mount-point = document.get-element-by-id store.get-state!main-content.mount-point-id
		component
			.render slug: params.slug
			.replace-children-of mount-point

		## Store active section
		component::redux-actions['app.active-section.set'] '/articles'


	/*
	** Project listing
	*/

	'projects': (params) ->
		const component   = require 'components/projects/projects'
		const store       = component::redux-store
		const mount-point = document.get-element-by-id store.get-state!main-content.mount-point-id
		component
			.render!
			.replace-children-of mount-point

		## Store active section
		component::redux-actions['app.active-section.set'] '/projects'


	/*
	** Project
	*/

	'project': (params) ->
		const component   = require 'components/projects/project-detail'
		const store       = component::redux-store
		const mount-point = document.get-element-by-id store.get-state!main-content.mount-point-id
		component
			.render slug: params.slug
			.replace-children-of mount-point

		## Store active section
		component::redux-actions['app.active-section.set'] '/projects'

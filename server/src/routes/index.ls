require! 'keystone'
require! './middleware'

const ObjectId = keystone.mongoose.Types.ObjectId


## Load common middleware
keystone.pre 'routes', middleware.init-error-handlers
keystone.pre 'routes', middleware.init-locals
keystone.pre 'render', middleware.flash-messages


## Init error handlers
keystone.set '404', (req, res, next) ->
	res.notfound!

keystone.set '500', (err, req, res, next) ->
	title = undefined
	if err instanceof Error
		message = err.message
		err = err.stack
	res.err err, title, message


## Load routes
routes =
	views:
		index: (req, res, next) ->
			tpl = require '~/server/dist/templates/layouts/main.marko'
			view = new keystone.View req, res
			res.marko tpl

		api:

			/*
			** Article listing
			*/

			articles: (req, res, next) ->
				const Post  = keystone.list 'Post'

				query = Post.model
				ids   = req.query.ids

				if ids
					ids = [].concat ids
					const object-ids = ids.map ->
						keystone.mongoose.Types.ObjectId it
					query = query.find _id: $in: ids
				else
					query = query.find!

				query
					.where 'state', 'published'
					.where 'type', 'article'
					.populate 'author', '-password'
					.sort '-publishedAt'
					.exec (error, posts) ->
						if error then res.send { error }
						else     then res.send error: null, count: posts.length, result: posts


			/*
			** Article
			*/

			article: (req, res, next) ->
				const slug-or-id = req.params.slug
				const Post       = keystone.list 'Post'
				const is-id      = is-valid-id slug-or-id

				item =
					if is-id then Post.model.find-by-id slug-or-id
					else          Post.model.find-one slug: slug-or-id

				item
					.populate 'author', '-password'
					.exec (error, post) ->
						if error then res.send { error }
						else     then res.send error: null, count: if post then 1 else 0, result: post


			/*
			** Project listing
			*/

			projects: (req, res, next) ->
				const Project = keystone.list 'Project'

				query = Project.model
				ids   = req.query.ids

				if ids
					ids = [].concat ids
					const object-ids = ids.map ->
						keystone.mongoose.Types.ObjectId it
					query = query.find _id: $in: ids
				else
					query = query.find!

				query
					.find!
					.where 'state', 'published'
					.populate 'tags'
					.sort '-publishedAt'
					.exec (error, projects) ->
						if error then res.send { error }
						else     then res.send error: null, count: projects.length, result: projects


			/*
			** Project
			*/

			project: (req, res, next) ->
				const slug-or-id = req.params.slug
				const Project    = keystone.list 'Project'
				const is-id      = is-valid-id slug-or-id

				item =
					if is-id then Project.model.find-by-id slug-or-id
					else          Project.model.find-one slug: slug-or-id

				item
					.populate 'tags'
					.exec (error, project) ->
						if error then res.send { error }
						else     then res.send error: null, count: if project then 1 else 0, result: project


			/*
			** Tag listing
			*/

			tags: (req, res, next) ->
				const Tag = keystone.list 'Tag'
				Tag.model
					.find!
					.where 'state', 'enabled'
					.sort 'name'
					.exec (error, tags) ->
						if error then res.send { error }
						else     then res.send error: null, count: tags.length, result: tags




## Bind routes
module.exports = (app) ->
	app.all '/api/*', keystone.middleware.cors
	app.options '/api/*', (req, res) -> res.send 200

	app.get '/api/posts', routes.views.api.articles
	app.get '/api/posts/:slug', routes.views.api.article

	app.get '/api/projects', routes.views.api.projects
	app.get '/api/projects/:slug', routes.views.api.project

	app.get '/api/tags', routes.views.api.tags

	app.get '/*', routes.views.index



## Determine if slug-or-id is a valid ObjectID — http://stackoverflow.com/a/29231016
function is-valid-id slug-or-id
	try if slug-or-id is (new ObjectId slug-or-id).to-string! then yes else no

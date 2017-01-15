require! 'marko-widgets'
require! 'entities'
require! 'dom'

require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		articles: state.articles
		error   : state.error
		busy    : state.busy

	get-initial-state: (input, out) ->
		articles: input.articles
		error   : no
		busy    : no


	init: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

		## Update document title
		dom.set-title 'Articles'

		## Fetch articles
		this.fetch-posts!


	##
	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix


	##
	fetch-posts: ->

		## Reset some state
		this.set-state error: no, busy: yes

		## Get api config
		const api-config = this.redux-store.get-state!.app.api

		## Fetch data
		res <~ entities.fetch 'posts', {}, api-config

		this.set-state busy: no

		## Handle response
		if res.error
			this.set-state error: yes
		else
			this.set-state articles: res.result

require! 'marko-widgets'
require! 'entities'

require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		tags       : state.tags
		error      : state.error
		busy       : state.busy
		initialised: state.initialised

	get-initial-state: (input, out) ->
		tags       : input.tags
		error      : no
		busy       : no
		initialised: no


	init: ->

		## Fetch tags
		this.fetch-tags!


	##
	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

		##
		set-timeout (~> this.set-state 'initialised', yes), 25


	##
	fetch-tags: ->

		## Reset some state
		this.set-state error: no, busy: yes

		## Get api config
		const api-config = this.redux-store.get-state!.app.api

		## Fetch data
		res <~ entities.fetch 'tags', id: this.state.slug, api-config

		this.set-state busy: no

		## Handle response
		if res.error
			this.set-state error: yes
		else
			this.set-state tags: res.result

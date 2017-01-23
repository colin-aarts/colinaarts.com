require! 'marko-widgets'
require! 'entities'

require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		projects: state.projects
		error   : state.error
		busy    : state.busy
		ids     : state.ids

	get-initial-state: (input, out) ->
		projects: input.projects
		error   : no
		busy    : no
		ids     : input.ids


	init: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

		## Fetch projects
		this.fetch-projects!


	##
	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix


	##
	fetch-projects: ->

		## Reset some state
		this.set-state error: no, busy: yes

		## Get api config
		const api-config = this.redux-store.get-state!.app.api

		## Fetch data
		res <~ entities.fetch 'projects', ids: this.state.ids, api-config

		this.set-state busy: no

		## Handle response
		if res.error
			this.set-state error: yes
		else
			this.set-state projects: res.result

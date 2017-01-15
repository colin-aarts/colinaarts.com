require! 'marko-widgets'

require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		tags : state.tags.sort (a, b) -> a.name > b.name
		links: state.links ? yes

	get-initial-state: (input, out) ->
		tags : input.tags
		links: input.links


	init: ->

	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

		##
		set-timeout (~> this.set-state 'initialised', yes), 25

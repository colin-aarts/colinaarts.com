require! 'marko-widgets'
require! 'fecha'

require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		const router = marko-widgets.Widget::redux-store.get-state!.app.router

		item: state.item <<<
			href: router.generate 'project', slug: state.item.slug
		initialised: state.initialised


	get-initial-state: (input, out) ->
		item: input.item
		initialised: no


	init: ->


	on-render: ->
		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

		##
		set-timeout (~> this.set-state 'initialised', yes), 25

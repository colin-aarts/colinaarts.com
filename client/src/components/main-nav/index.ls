require! 'marko-widgets'
require! 'redux-watch'

require! './style'
require! './template'


##
module.exports = marko-widgets.define-component do
	template: template

	get-template-data: (state, input) ->
		active: state.active

	get-initial-state: (input, out) ->
		const store = marko-widgets.Widget::redux-store
		active: store.get-state!.app.active-section or ''

	init: ->
		const el    = this.el
		const store = this.redux-store

		## Watch for state changes
		const w = redux-watch store.get-state, 'app.activeSection'
		store.subscribe w (new-value, old-value, store-path) ~>
			this.set-state 'active', new-value

	on-render: ->
		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

require! 'marko-widgets'
require! 'dom'

require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->

	get-initial-state: (input, out) ->

	init: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

		## Update document title
		dom.set-title 'Work'


	##
	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

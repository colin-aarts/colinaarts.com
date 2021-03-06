require! 'marko-widgets'
require! 'entities'

require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		const router = marko-widgets.Widget::redux-store.get-state!.app.router

		articles-link: router.generate 'articles'
		projects-link: router.generate 'projects'

	get-initial-state: (input, out) ->

	init: ->


	##
	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

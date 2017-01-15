require! 'marko-widgets'
require! 'redux-watch'
require! 'dom'

require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		made-with:
			* name: 'LiveScript'   , href: 'https://livescript.net/'
			* name: 'Stylus'       , href: 'http://stylus-lang.com/'
			* name: 'WebPack'      , href: 'https://webpack.github.io/'
			* name: 'Marko Widgets', href: 'http://markojs.com/'
			* name: 'Redux'        , href: 'http://redux.js.org/'
			* name: 'Navigo'       , href: 'http://work.krasimirtsonev.com/git/navigo/'
			* name: 'KeystoneJS'   , href: 'http://keystonejs.com/'
			* name: 'Sublime'      , href: 'https://www.sublimetext.com/'

	get-initial-state: (input, out) ->


	init: ->
		const store = this.redux-store

		## Watch for active-section state changes
		const w = redux-watch store.get-state, 'app.activeSection'
		store.subscribe w (new-value, old-value, store-path) ~>
			# this.set-state 'activeSection', new-value
			# Err… bit of a hack, since the root element isn't part of any Marko Widget just DOM it directly.
			# This is the top-level widget, so it makes the most sense to do it here. No point in using widget state, though.
			document.document-element.set-attribute 'data-active-section', new-value


	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

		##
		dom.mark-object-anchors el

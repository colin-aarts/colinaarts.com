require! 'marko-widgets'
require! 'photoswipe': PhotoSwipe
require! 'photoswipe/dist/photoswipe-ui-default': PhotoSwipeUI

require! './style'
require! './template'

require! '../../../../node_modules/photoswipe/dist/photoswipe.css'
require! '../../../../node_modules/photoswipe/dist/default-skin/default-skin.css'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		images: state.images
		poster: state.poster

	get-initial-state: (input, out) ->
		images: input.images
		poster: input.poster

	init: ->

	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

		##
		set-timeout (~> this.set-state 'initialised', yes), 25


	## The overlay code for PhotoSwipe needs to be injected manually, and should go directly inside of <body>, so…
	## This method checks and returns a reference to the root element of the dialog if it exists, and creates and returns it otherwise.
	get-dialog-el: ->

		# Test for
		dialog-el = document.get-element-by-id 'gallery-dialog'
		return that if dialog-el

		require! './dialog'
		const dialog-str = dialog.render-sync!
		const range      = document.create-range!
		const dialog-dom = range.create-contextual-fragment dialog-str

		dialog-el = dialog-dom.children.0
		document.body.append-child dialog-dom
		return dialog-el


	## Show gallery
	show-gallery: ->
		const dialog-el = this.get-dialog-el!
		const images    = this.state.images.map -> src: it.gallery, w: it.width, h: it.height
		const gallery   = new PhotoSwipe dialog-el, PhotoSwipeUI, images, { -close-on-scroll, -history, -click-to-close-non-zoomable }
		gallery.init!

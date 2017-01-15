require! 'marko-widgets'
require! 'entities'
require! 'dom'

require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		const router = marko-widgets.Widget::redux-store.get-state!.app.router

		article    : state.article
		slug       : state.slug
		error      : state.error
		busy       : state.busy
		initialised: state.initialised
		permalink  : router.generate 'article', slug: state.article?.id
		canonical  : router.generate 'article', slug: state.article?.slug
		link-back  : router.generate 'articles'

	get-initial-state: (input, out) ->
		article    : input.article
		slug       : input.slug
		error      : no
		busy       : no
		initialised: no


	init: ->

		## Fetch article
		this.fetch-post!


	##
	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		el.class-list.add style.prefix

		##
		set-timeout (~> this.set-state 'initialised', yes), 25

		## Update document title
		if this.state.article?.title then dom.set-title that

		## Init Disqus widget — after setting the title, Disqus needs the proper document title to be set
		if this.get-widget 'disqus'
			try that.reset!

		## Code highlighting
		dom.init-code-highlighting!

		## Generate section anchors
		for section in this.el.query-selector-all 'section'
			return unless section.id
			const h1 = section.query-selector 'h1'
			return unless h1
			(const anchor = document.create-element 'a')
				..class-name   = 'section-anchor'
				..text-content = '§'
				..href         = "##{section.id}"
				..title        = 'Direct link to this section'
			h1.append-child anchor


	##
	fetch-post: ->

		## Reset some state
		this.set-state error: no, busy: yes

		## Get api config
		const api-config = this.redux-store.get-state!.app.api

		## Fetch data
		res <~ entities.fetch 'posts', id: this.state.slug, api-config

		this.set-state busy: no

		## Handle response
		if res.error
			this.set-state error: yes
		else
			this.set-state article: res.result

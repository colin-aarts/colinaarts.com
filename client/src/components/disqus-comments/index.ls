require! 'marko-widgets'

# require! './style'
require! './template'


module.exports = marko-widgets.define-component do

	template: template

	get-template-data: (state, input) ->
		id : state.id
		url: state.url

	get-initial-state: (input, out) ->
		id : input.id
		url: input.url


	init: ->

	on-render: ->

		const el = this.el

		## Attach style sheet identifier
		# el.class-list.add style.prefix


	## Call this explicitly from the parent component because it relies on the data source being available
	reset: ->
		const id  = this.state.id
		const url = this.state.url

		try
			DISQUS.reset do
				reload: yes
				config: ->
					# Special case some old threads without identifier…
					if id in <[ 57f865317ea3f425ed0d63e6 57faf8f4f67ee914159b53be 57fa6300fe5819accc0a0d5a ]>
						this.page.url = "http://colinaarts.com#url"
					else
						this.page.identifier = id

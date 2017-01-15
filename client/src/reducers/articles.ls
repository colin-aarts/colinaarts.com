const initial-state = {}

module.exports = (state = initial-state, action) ->

	{ type, payload } = action

	switch type

	case 'articles.set'
		const new-state = {} <<< state <<<
			ids: payload.articles
		return new-state

	default then return state

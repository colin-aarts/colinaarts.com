const initial-state = {}

module.exports = (state = initial-state, action) ->

	{ type, payload } = action

	switch type

	case 'article.update'
		const new-state = {} <<< state <<< payload.article
		return new-state

	default then return state

const initial-state = {}

module.exports = (state = initial-state, action) ->

	{ type, payload } = action

	switch type

	case 'main-content.mount-point.set'
		const new-state = {} <<< state <<<
			mount-point-id: payload.id
		return new-state

	default then return state

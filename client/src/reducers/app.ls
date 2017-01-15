const initial-state = {}

module.exports = (state = initial-state, action) ->

	{ type, payload } = action

	switch type

	##
	case 'app.active-section.set' then let
		const new-state = {} <<< state <<<
			active-section: payload.section
		return new-state

	##
	case 'app.router.set' then let
		const new-state = {} <<< state <<<
			router: payload.router
		return new-state

	##
	case 'app.api-config.set' then let
		const new-state = {} <<< state <<<
			api: {} <<< state.api <<< payload
		return new-state

	##
	default then return state


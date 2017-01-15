require! 'redux'

module.exports = redux.combine-reducers do
	app         : require './app'
	main-content: require './main-content'
	articles    : require './articles'
	article     : require './article'

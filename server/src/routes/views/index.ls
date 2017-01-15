require! 'keystone'
require! '../../templates/views/home.marko': tpl

module.exports = (req, res, next) ->
	view = new keystone.View req, res
	res.marko tpl,
		var1: 'variable'

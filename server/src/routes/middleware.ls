keystone = require 'keystone'

##
exports.init-locals = (req, res, next) ->
	locals = res.locals
	locals.user = req.user

	next!

##
exports.init-error-handlers = (req, res, next) ->

	res.err = (err, title, message) ->
		console.log err
		res.status 500 .render 'errors/500',
			err: err,
			error-title: title
			error-msg: message

	res.notfound = (title, message) ->
		res.status 404 .render 'errors/404',
			error-title: title
			error-msg: message

	next!


##
exports.flash-messages = ->

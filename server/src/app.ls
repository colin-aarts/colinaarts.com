require 'require-self-ref'

require 'marko/express'
require 'marko/node-require' .install!

require! 'keystone'
require! 'fecha'
require! 'path'
require! 'fs'


## Set up fecha
fecha.masks.long = 'dddd D MMMM, YYYY'


## Set up keystone
keystone.init do
	'name': 'colinaarts.com'
	'favicon': 'public/favicon.ico'
	'static': <[ public ]>
	'cors allow origin': yes

	'views': 'templates/views'
	'view engine': 'marko'

	'auto update': yes

	'mongo': process.env.MONGODB_URI

	'session': yes
	'session store': 'mongo'
	'auth': yes
	'user model': 'User'
	'cookie secret': process.env.cookiesecret
	'logger': '[:date[web]] :method :url :status (:response-time ms)'
	'compress': no

	'ssl': yes
	'ssl key': path.resolve __dirname, '../../secure/key.pem'
	'ssl cert': path.resolve __dirname, '../../secure/cert.pem'

	## Cloudinary
	'cloudinary config': process.env.CLOUDINARY_URI
	'cloudinary folders': yes
	'cloudinary secure': yes

require './models'

keystone.set 'routes', require './routes'

keystone.start!

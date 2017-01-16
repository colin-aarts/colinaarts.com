require! 'webpack'
require! 'fs'
require! 'path'

console.log 'NODE_ENV = ' + process.env.NODE_ENV

module.exports =
	entry:
		app: path.resolve __dirname, 'src/app.ls'
	output:
		path       : path.resolve __dirname, '../server/dist/public/'
		public-path: if process.env.NODE_ENV isnt 'production' then 'https://localhost:8080/' else ''
		filename   : '[name].js'
	module:
		loaders:
			* test: /\.ls$/      , loader: 'livescript'
			* test: /\.js$/      , loader: 'babel', query: presets: <[ es2016 es2015 ]>
			* test: /\.marko$/   , loader: 'marko'
			* test: /\.styl|css$/, loader: if process.env.NODE_ENV isnt 'production' then 'style?sourceMap!css?sourceMap!stylus?sourceMap' else 'style!css!stylus'
			* test: /\.json$/    , loader: 'json'
			* test: /\.(ttf|otf|eot|svg|png|jpe?g|gif|woff2?)/, loader: 'file'
	plugins:
		new webpack.DefinePlugin 'process.env': 'NODE_ENV': JSON.stringify process.env.NODE_ENV
		new webpack.HotModuleReplacementPlugin! if process.env.NODE_ENV isnt 'production'
	resolve:
		extensions: <[ .ls .js .marko .styl .css ]> ++ ''
		root      : path.resolve __dirname, 'src'
		alias:
			fetch: 'fetch-ponyfill'
	dev-server:
		hot         : yes
		inline      : yes
		content-base: path.resolve __dirname, '../server/dist/public/'
		https       : yes
		cert        : fs.read-file-sync (path.resolve __dirname, '../secure/cert.pem'), 'utf-8'
		key         : fs.read-file-sync (path.resolve __dirname, '../secure/key.pem'), 'utf-8'
		headers:
			'Access-Control-Allow-Headers': 'Content-Type, Authorization, DPR, Width, Viewport-Width'
			'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE,OPTIONS'
			'Access-Control-Allow-Origin' : '*'


express = require 'express'
jade = require 'jade'
global.controls = require './public/js/controls'
#global.dbsettings = require './conf/database.json'
routes = require './public/js/routes'
http = require 'http'
path = require 'path'


app = express()

app.configure ->
	app.set 'port', process.env.PORT || 2527
	app.set 'views', __dirname + '/layout/smarty'
	app.set 'view engine', 'jade'
	app.use express.cookieParser()
	app.use express.session (
		secret: 'asfa'
		cookie: 
			path: '/'
			httpOnly: true
			maxAge: 1000*60*60*24
		)
	app.use express.logger 'dev'
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router
	app.use express.static __dirname

app.configure 'development', () ->
	app.use express.errorHandler()

app.all '/', (req, res) ->
	switch req.query.action
		when 'get'
			routes.get req, res
	console.log req.query

http.createServer(app).listen app.get('port'), () ->
	console.log "Express server listening on port " + app.get('port')


###
program = require 'commander'
global.controls = require './public/js/controls'
#global.dbsettings = require './conf/database.json'
#global.appsettings = require './settings/sms.json'
routes = require './public/js/routes'

global.program = program
					.version('0.0.1')
					.option('-d, --debug','Show response in log')
					.parse(process.argv)

routes.index()
###
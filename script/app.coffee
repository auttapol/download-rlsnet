
program = require 'commander'
global.dbsettings = require(__dirname + '/conf/database.json')
routes = require(__dirname + '/public')

global.program = program
					.version('0.0.1')					
					.option('-i, --index <n>','Index in URL list', parseInt)
					.option('-d, --debug','Show response in log')
					.parse(process.argv)

routes.get()


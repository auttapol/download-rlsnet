
exports.connect = (cn, callback) ->
	global.clientAnswer = ''
	net = global.controls.lib.net.init()
	client = net.connect cn.connect.port, cn.connect.ip
	callback client if callback

exports.getAllMessages = (client, cn, callback) ->
	colors = global.controls.lib.colors.init()
	
	client.write cn.connect.login + '\n'
	client.write cn.connect.password + '\n'
	client.write 'en' + '\n'
	client.write cn.commands.getAllMessages.cmd + '\n'
	client.write 'exit' + '\n'
	client.write 'exit' + '\n'

	client.on 'data', (data) ->
		global.clientAnswer += data.toString()

	client.on 'error', (err) ->
		console.log 'telnet:'.error, err.message.data

	client.on 'close', () ->
		if global.clientAnswer != ''
			console.log global.clientAnswer.data if global.program.debug
			ms = global.controls.parser.snParseMessages global.clientAnswer 
			if parseInt(ms.length) > 0 
				console.log 'client:'.info, parseInt(ms.length).toString().data, 'new sms'.data
				callback ms if callback
			else 
				console.log 'client:'.warn, parseInt(ms.length).toString().data, 'new sms'.data
		else 
			console.log 'telnet:'.error, 'data not found'.data

exports.insertMessageIntoBase = (data, cn, db, callback) ->
	global.controls.db.query global.controls.sql.sms.insertMessageIntoBase(data,cn), db, (result) ->
		callback result if callback

exports.rmAllMessages = (client, cn, callback) ->
	colors = global.controls.lib.colors.init()

	client.write cn.connect.login + '\n'
	client.write cn.connect.password + '\n'
	client.write 'en' + '\n'
	client.write cn.commands.rmAllMessages.cmd + '\n'
	client.write 'exit' + '\n'
	client.write 'exit' + '\n'

	client.on 'close', () ->
		do callback if callback




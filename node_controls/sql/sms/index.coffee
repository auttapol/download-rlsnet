
exports.insertMessageIntoBase = (data, cn) ->
	sanitize = global.controls.lib.validator.sanitize()
	table = cn.tables.messages.name
	fields = cn.tables.messages.fields

	'insert into ' + table + ' ' +
	'("' + fields.index + '","' + fields.sim + '","' + fields.phone + '","' + fields.date + '","' + fields.text + '") values ' +
	'(\'' + sanitize(data.id).toInt() + '\',\'' + sanitize(data.sim).toInt() + '\',\'' + sanitize(data.phone).escape() + '\',\'' + sanitize(data.date.datetime).escape() + '\',\'' + sanitize(data.text).escape() + '\')'

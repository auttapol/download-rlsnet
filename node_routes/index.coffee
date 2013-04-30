
exports.index = (req, res) ->

	colors = global.controls.lib.colors()

	console.log 'start'.data
	res.jsonp({ user: 'tobi' })

exports.get = () ->

	colors =			global.controls.lib.colors()
	check =				require('validator').check
	sanitize =			require('validator').sanitize
	iconv =				require('iconv-lite')
	get =				require 'get'
	mysql =				require 'mysql'

	insertIntoBase = (caption, name, link) ->
		values =
			caption:	caption
			name:		name
			ind:		index
			url:		url
			link:		link
		cn.query 'insert into rlsnet set ?', values, (err) ->
			if !err
				console.log caption.data, name.info


	getCaption = (value) ->
		value = clearText(value)
		value = value.replace(/(.*?)<div id="div_nest">(.*?)$/,'$2')
		value = value.replace(/(.*?)<h2>(.*?)<\/h2>(.*?)<h2>(.*)/i,'$3')
		value = value.replace(/<img(.*?)>/,'')
		value = value.replace(/<a(.*?)><\/a>/,'')
		value

	getName = (value, res = null) ->
		if value.match(/<a(.*?)>(.*?)<\/a>/i)
			res = value.replace(/(.*)<a(.*?)>(.*?)<\/a>(.*)/i,'$3')
			res = sanitize(res).escape()
			res = sanitize(res).entityEncode()
			res = clearTags(res)
		res

	getNames = (value, res = []) ->
		value = clearText(value)
		value = value.replace(/(.*?)<table border="0" cellspacing="0" cellpadding="0" width="100%" class="rest_nest" id="tblpanel">(.*?)$/,'$2')
		if value?
			res = value.match(/<td class="rest_data"(.*?)<\/td>/gi)
		res



	checkLink = (link, callback) ->
		if link?
			cn.query 'select * from rlsnet where link = ?', link, (err, rows) ->
				if !(rows? and rows[0]? and rows[0].id > 0)
					callback() if callback


	clearText = (text) -> 
		if text?
			text = text.replace(/\n/gi,'')
			text = text.replace(/\r/gi,'')
			text = text.replace(/\t/gi,'')
		text

	clearTags = (text) -> 
		if text?
			text = text.replace(/\&?amp\;?/gi,'')
			text = text.replace(/\&?nbsp\;?/gi,' ')
			text = text.replace(/\&?lt\;?/gi,'')
			text = text.replace(/\&?gt\;?/gi,'')
			text = text.replace(/\&?trade\;?/gi,'')
			text = text.replace(/<?\/?sup>?/gi,'')
			text = text.replace(/\&?reg\;?/gi,'')
		text

	parsePage = (page, link = '') ->
		if page?
			caption = getCaption(page)
			names = getNames(page)
			if names?
				names.filter (value, i) ->
						name = getName (value)
						if name? and caption?
							insertIntoBase(caption, name, link)


	getPage = (link) ->
		if link?
			get(link).asBuffer (err, b) ->
				if !err
					page = iconv.decode(b, 'win1251')
					parsePage page, link


	getLinks = (links) ->
		if links?
			links.filter (value, i) ->
				link = value.replace(/href="(.*?)"/i,'$1')
				checkLink link, () ->
					console.log 'link'.data, link.debug
					getPage link

	urls = (i = 0) ->
		def = [
			'http://www.rlsnet.ru/mnn_alf_letter_2.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_C0.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_C1.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_C2.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_C3.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_C4.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_C6.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_C7.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_C8.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_C9.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_CA.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_CB.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_CC.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_CD.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_CE.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_CF.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_D0.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_D1.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_D2.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_D3.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_D4.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_D5.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_D6.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_D7.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_D8.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_DD.htm'
			'http://www.rlsnet.ru/mnn_alf_letter_DF.htm'
		]
		
		def[i]




	if global.dbsettings?
		cn = mysql.createConnection
			host :			global.dbsettings.connections.mysql.host
			user :			global.dbsettings.connections.mysql.login
			password :		global.dbsettings.connections.mysql.password
			database :		global.dbsettings.connections.mysql.dbname

	if cn?
		cn.connect()

		if global.program? and global.program.index? 
			index = global.program.index
		else 
			index = 0

		url = urls index	
		if url?
			console.log url.debug
			get(uri: url).asBuffer (err, b) ->
				data = iconv.decode(b, 'win1251')
				if !err
					console.log 'parsing...'.data
					div = clearText(data)
					div = div.replace(/(.*?)<div class="tn_alf_list">(.*?)<div class="new_sub_slices">(.*)/i,'$2')
					getLinks div.match(/href="(.*?)"/gi)

			



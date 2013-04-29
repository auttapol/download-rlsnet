
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
			text = text.replace(/<?\/?sup>?/gi,'')
			text = text.replace(/\&?reg\;?/gi,'')
		text

	parsePage = (page, link = '') ->
		if page?
			#h = $('#div_nest', page).html()
			h = clearText(page)
			h = h.replace(/(.*?)<div id="div_nest">(.*?)$/,'$2')
			h = h
			div = clearText(page)
			div = div.replace(/(.*?)<table border="0" cellspacing="0" cellpadding="0" width="100%" class="rest_nest" id="tblpanel">(.*?)$/,'$2')
			if div?
				caption = h.replace(/(.*?)<h2>(.*?)<\/h2>(.*?)<h2>(.*)/i,'$3')
				caption = caption.replace(/<img(.*?)>/,'')
				caption = caption.replace(/<a(.*?)><\/a>/,'')
				names = div.match(/<td class="rest_data"(.*?)<\/td>/gi)
				if names?
					names.filter (value, i) -> 
						if value.match(/<a(.*?)>(.*?)<\/a>/i)
							name = value.replace(/(.*)<a(.*?)>(.*?)<\/a>(.*)/i,'$3')
							name = sanitize(name).escape()
							name = sanitize(name).entityEncode()
							name = clearTags(name)
							console.log caption.data, name.info

							values =
								caption:	caption
								name:		name
								ind:		index
								url:		url
								link:		link
							cn.query 'insert into rlsnet set ?', values, (err) ->
								throw err if err


	getPage = (link) ->
		if link?
			get(link).asBuffer (err, b) ->
				throw err if err
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
			console.log url
			get(uri: url).asBuffer (err, b) ->
				data = iconv.decode(b, 'win1251')
				throw err if err
				console.log 'parsing...'.data
				div = clearText(data)
				div = div.replace(/(.*?)<div class="tn_alf_list">(.*?)<div class="new_sub_slices">(.*)/i,'$2')
				getLinks div.match(/href="(.*?)"/gi)

			




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
	htmlparser =		require 'htmlparser'
	$ =					require 'jquery'


	#iconv = new Iconv 'cp1251', 'utf-8'

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

	parsePage = (page) ->
		if page?
			h = $('#div_nest', page).html()
			h = clearText(h)
			div = $('#tblpanel', page).html()
			div = clearText(div)
			if div?
				caption = h.replace(/<!--tn_oglavlenie--><h2>(.*?)<\/h2>(.*?)<h2>(.*)/i,'$2')
				names = div.match(/<td class="rest_data"(.*?)<\/td>/gi)
				if names?
					names.filter (value, i) -> 
						if value.match(/<a(.*?)>(.*?)<\/a>/i)
							name = value.replace(/(.*)<a(.*?)>(.*?)<\/a>(.*)/i,'$3')
							name = sanitize(name).escape()
							name = sanitize(name).entityEncode()
							name = clearTags(name)
							console.log caption, name

							values =
								caption:	caption
								name:		name
							cn.query 'insert into rlsnet set ?', values, (err) ->
								throw err if err


				# console.log names
		###
		names = page.match(/<td class="rest_data">(.*?)<\/td>/gim)
		if names.length > 0
			names.filter (value, i) -> 
		###



	getPage = (link) ->
		if link?
			console.log link
			get(link).asBuffer (err, b) ->
				throw err if err
				page = iconv.decode(b, 'win1251')
				parsePage page


	getLinks = (links) ->
		if links?
			links.filter (value, i) ->
				link = value.replace(/href="(.*?)"/i,'$1')
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
			#charset :		global.dbsettings.connections.mysql.charset

	if cn?
		cn.connect()

		if program.index? 
			url = urls program.index
		else 
			url = urls 0

		#url = urls 0
		if url?
			console.log url
			get(uri: url, max_redirs: 0, 'no_proxy').asBuffer (err, b) ->
				data = iconv.decode(b, 'win1251')
				throw err if err
				console.log 'parsing...'
				# console.log data
				div = $('.tn_alf_list', data).html()
				getLinks div.match(/href="(.*?)"/gim)

				#cn.query 'insert into rlsnet set ?', values, (err) ->
				#	throw err if err
			



		
	###
	throw err if err
	res.jsonp
		href:			req.query.href
		fn:				req.query.fn
		html:			data
	###

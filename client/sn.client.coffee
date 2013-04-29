$ ->
	methods=
		init:(s = {}) ->

		getList: (s = {}) ->
			console.log 'getList'
			i = parseInt($('#page-first').val())
			$(this).snAjax 'get', (
					href: $(this).snConf('url', i)
					fn: 'parseList-dev'
				)

		parseList: (s = {}) ->
			console.log 'parseList'
			if s.html?
				$('.tn_alf_list', s.html).find('a').each (i) ->
					url = $(this).attr('href')
					console.log i, url
					if url?
						$(this).snAjax 'get', (
								href: url
								fn: 'parsePage'
							)

		parsePage: (s = {}) ->
			console.log 'parsePage'






	$.fn.snClient= (sn) ->
		sn={} if !sn
		if methods[sn]
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			methods.init.apply @,arguments



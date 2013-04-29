$ ->
	methods= 
		init: (options = {}) ->

		get: (options = {}) ->
			_this = this
			def=
				url:		'//api-dev.oz.st-n.ru'
				type:		'jsonp'
				action:		'get'
				href:		''
			$.extend true,def,options
			console.log 'request', def
			$.ajax 
				url:		def.url
				async:		on
				type:		'GET'
				data:		def
				dataType:	def.type
				timeout:	1000000

				success: (s) ->
					console.log 'response', s
					if s.fn?
						$(_this).snClient s.fn, s


		put:(options = {}) ->
			_this = this
			def=
				url:		'//api-dev.oz.st-n.ru'
				type:		'jsonp'
				action:		'put'
			$.extend true,def,options
			def.type='text' if def.debug
			$.ajax 
				url:		def.url
				type:		'GET'
				data: 		def
				dataType:	def.type
				timeout:	10000

				success: (s) ->
					console.log 'response', s

				
	$.fn.snAjax= (sn) ->
		sn={} if !sn
		if methods[sn] 
			methods[sn].apply this,Array.prototype.slice.call arguments,1
		else 
			methods.init.apply @,arguments




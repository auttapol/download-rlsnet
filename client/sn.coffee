$ ->
	methods= 
		init:(options) ->
			options={} if !options
			def=
				content:{}
				result:
					key:''
			$.extend true,def,options
			$(this).data 'sn',def
			$(this).snTriggers()

	$.fn.sn= (sn) ->
		sn={} if !sn
		if methods[sn] 
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'
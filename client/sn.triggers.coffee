$ ->
	methods=
		init: ->
			$(this).snTriggers 'start'
			$(this).snTriggers 'stop'

		start: ->
			th=$(this)
			$("#btn-start").on "click",(e) ->
				e.preventDefault()
				if parseInt($('#page-first').val()) <= parseInt($('#page-last').val())
					th.snEvents href:'#start'

		stop: ->
			th=$(this)
			$("#btn-stop").on "click",(e) ->
				e.preventDefault()
				th.snEvents href:'#stop'

	$.fn.snTriggers= (sn) ->
		sn={} if !sn
		if methods[sn]
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'


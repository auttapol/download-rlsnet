$ ->
	methods=
		init: ->
			$(this).snTriggers 'start'
			$(this).snTriggers 'stop'

		start: ->
			_this = this
			$("#btn-start").on "click",(e) ->
				e.preventDefault()
				if parseInt($('#page-first').val()) <= parseInt($('#page-last').val())
					$(_this).snEvents href:'#start'

		stop: ->
			_this = this
			$("#btn-stop").on "click",(e) ->
				e.preventDefault()
				$(_this).snEvents href:'#stop'

	$.fn.snTriggers= (sn) ->
		sn={} if !sn
		if methods[sn]
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			methods.init.apply @,arguments


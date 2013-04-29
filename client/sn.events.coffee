$ ->
	methods=
		init:(options = {}) ->


			def=
				href:'none'
			$.extend true,def,options
			sn=$(this).data 'sn'
			href=def.href
			switch href.replace /(.*)#(.*)/,'$2'
				when "autoload" then
				
				when "content"
					console.log 'content' 
					$(this).snAjax 'getContentFromSite'
				
				when "afterGet"
					# alert sn.result.text
					if sn.result
						if sn.result.response
							$("#response").html sn.result.text
							# +$("#response").html()
					$('#page-first').val parseInt($('#page-first').val())+1
					
					# if parseInt($('#page-first').val()) <= parseInt($('#page-last').val())
					#	if $('#status').val() == 'start'
					#		$(this).snEvents href:'#get'

				when "start"
					console.log 'start'
					$(this).snClient 'getList'
					#if $('#status').val() == 'stop'
						#$('#btn-start').hide()
						#$('#btn-stop').show()
						#$('#status').val('start')
						#$(this).snEvents href:'#content'

				when "stop" then
					#if $('#status').val() == 'start'
						#$('#btn-start').show()
						#$('#btn-stop').hide()
						#$('#status').val('stop')

				when "close" then $(this).hide()


	$.fn.snEvents= (sn) ->
		sn={} if !sn
		if methods[sn]
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'



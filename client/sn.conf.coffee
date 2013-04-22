$ ->
	methods=
		init:(options = {}) ->

		url:(i = 'A') ->
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



	$.fn.snConf= (sn) ->
		sn={} if !sn
		if methods[sn]
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			methods.init.apply @,arguments




exports.index = (req, res) ->

	colors = global.controls.lib.colors()

	console.log 'start'.data
	res.jsonp({ user: 'tobi' })


exports.get = (req, res) ->
	get = require 'get'
	htmlparser = require 'htmlparser'
	$ = require 'jquery'
	
	if req.query.href?
		get(req.query.href).asString (err, data) ->
			throw err if err
			console.log $('a', data).each () ->
				$('a', this).html()



			###
			handler = new htmlparser.DefaultHandler (error, dom) ->
				throw error if error
				console.log dom

			parser = new htmlparser.Parser handler
			parser.parseComplete data
			###



		
		###
		throw err if err
		res.jsonp
			href:			req.query.href
			fn:				req.query.fn
			html:			data
		###

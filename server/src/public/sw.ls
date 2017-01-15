this.add-event-listener 'fetch', (e) ~>

	const req = e.request
	const url = new URL req.url

	if url.host is 'res.cloudinary.com' and not req.headers.get 'width'

		const headers = new Headers do
			width: 1000

		req.headers.for-each (v, k) ->
			headers.set k, v

		const new-req = new Request req,
			mode       : 'cors'
			credentials: 'omit'
			headers    : headers

		e.respond-with fetch new-req

const authors =
    0:
        id: 1
        name: 'Colin'

module.exports =
    error: no
    results: 2
    articles:
        *   id: 1
            datePublished: '2010-02-16T21:12:23.503Z'
            title: 'Test article'
            summary: 'Article summary…'
            body: '<p>Test</p>'
            author: authors.0
        *   id: 2
            datePublished: '2010-03-02T16:56:23.503Z'
            title: 'Another test article'
            summary: 'Article summary…'
            body: '<p>Another test</p><p>Another test</p><p>Another test</p><p>Another test</p>'
            author: authors.0
        *   id: 3
            datePublished: '2012-11-22T11:56:23.503Z'
            title: 'Another test article'
            summary: 'Article summary…'
            body: 'Bla bla'
            author: authors.0
        *   id: 4
            datePublished: '2016-09-29T23:56:23.503Z'
            title: 'Another test article'
            summary: 'Article summary…'
            body: '<p>Another test</p>'
            author: authors.0

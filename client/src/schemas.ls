require! 'normalizr': { Schema }


## User
const user = new Schema 'user'


## Article
const article = new Schema 'article'
article.define do
	author: user



## Exports
module.exports = { user, article }

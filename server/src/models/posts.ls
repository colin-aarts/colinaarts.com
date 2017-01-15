require! 'keystone'
require! 'fecha'
require! '~/server/src/model-clean-cyclic'


##
const types = keystone.Field.Types

const Post = new keystone.List 'Post',
	autokey     : path: 'slug', from: 'title', unique: yes
	map         : name: 'title'
	default-sort: '-publishedAt'
	drilldown   : 'author'
	track       : yes


Post.add do
	title       : type: String                                                                 , required: yes, index: yes
	state       : type: types.Select, options: 'draft, published, archived', default: 'draft'  , required: yes, index: yes
	type        : type: types.Select, options: 'article'                   , default: 'article', required: yes, index: yes
	author      : type: types.Relationship, ref: 'User'                                        , required: yes, index: yes, initial: yes
	published-at: Date
	image       : type: types.CloudinaryImage, auto-cleanup: yes, select: yes
	content     :
		brief   : type: types.Html                                                             , required: yes, index:yes , initial: yes
		extended: type: types.Html                                                             , required: yes            , initial: yes

Post.default-columns = 'title, type, state, author, publishedAt'


/*
** Virtuals
*/


## Patch toJSON…
Post.schema.set 'toJSON',
	virtuals : yes
	transform: model-clean-cyclic.transformer

## Formatted dates
Post.schema.virtual 'createdAtFmt'   .get -> fecha.format (new Date this.created-at)  , 'long'
Post.schema.virtual 'updatedAtFmt'   .get -> fecha.format (new Date this.updated-at)  , 'long'
Post.schema.virtual 'publishedAtFmt' .get -> fecha.format (new Date this.published-at), 'long'

## Image variants
Post.schema.virtual 'image.listing'   .get -> this._.image.src width: 400 , quality: 75
Post.schema.virtual 'image.fullwidth' .get -> this._.image.src width: 1920, quality: 75


/*
** Pre-hooks
*/

Post.schema.pre 'save', (next) ->
	if this.is-modified 'state' and this.state is 'published' and not this.published-at
		this.published-at = new Date
	next!


## Register
Post.register!

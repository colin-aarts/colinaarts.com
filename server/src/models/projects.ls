require! 'keystone'
require! 'fecha'
require! '~/server/src/model-clean-cyclic'


##
const types = keystone.Field.Types

const Project = new keystone.List 'Project',
	autokey     : path: 'slug', from: 'title', unique: yes
	map         : name: 'title'
	default-sort: '-publishedAt'
	drilldown   : 'author'
	track       : yes


Project.add do
	title       : type: String                                                                      , required: yes, index: yes
	state       : type: types.Select, options: 'draft, published, archived', default: 'draft'       , required: yes, index: yes
	type        : type: types.Select, options: 'professional, hobby'       , default: 'professional', required: yes, index: yes
	author      : type: types.Relationship, ref: 'User'                                             , required: yes, index: yes, initial: yes
	published-at: type: types.Date, year-range: [2000, 2020]                                        , required: yes            , initial: yes
	timespan    : type: String                                                                      , required: yes            , initial: yes
	logo        : type: types.CloudinaryImage , auto-cleanup: yes
	image       : type: types.CloudinaryImage , auto-cleanup: yes, select: yes
	images      : type: types.CloudinaryImages, auto-cleanup: yes, select: yes
	repository  : type: types.Url                                                                                  , index: yes
	demo        : type: types.Url                                                                                  , index: yes
	tags        : type: types.Relationship, ref: 'Tag', many: yes
	links       : type: types.TextArray
	ip-notice   : type: Boolean                                             , default: no
	legal-name  : type: String
	content     :
		brief   : type: types.Html                                                                  , required: yes, index:yes , initial: yes
		extended: type: types.Html                                                                  , required: yes            , initial: yes

Project.default-columns = 'title, type, state, author, publishedAt'


/*
** Virtuals
*/


## Patch toJSON…
Project.schema.set 'toJSON',
	virtuals : yes
	transform: model-clean-cyclic.transformer

Project.schema.paths.images.schema.set 'toJSON',
	virtuals : yes
	transform: model-clean-cyclic.transformer

## Formatted dates
Project.schema.virtual 'createdAtFmt'   .get -> fecha.format (new Date this.created-at)  , 'YYYY'
Project.schema.virtual 'updatedAtFmt'   .get -> fecha.format (new Date this.updated-at)  , 'YYYY'
Project.schema.virtual 'publishedAtFmt' .get -> fecha.format (new Date this.published-at), 'YYYY'

## Eh
Project.schema.virtual 'links_' .get ->
	this.links.map -> JSON.parse it



/*
** Image variants
*/


## Poster images
let
	const conf = (w) ->
		transformation:
			* width: w, quality: 75, angle: 2, effect: 'blur:300'
			* effect: 'brightness_hsb:-30'

	Project.schema.virtual 'image.listing'   .get -> this._.image.src conf 400
	Project.schema.virtual 'image.fullwidth' .get -> this._.image.src conf 1920
	Project.schema.virtual 'image.thumb'     .get -> this._.image.src width: 'auto:100:200', effect: 'blur:300', angle: 2, quality: 75

## Logo
Project.schema.virtual 'logo.thumb' .get -> this._.logo.src width: 'auto:100:200'

## Gallery images
Project.schema.paths.images.schema.virtual 'gallery' .get -> this.src do
	overlay: text: 'CONCEPT', font_family: 'Arial', font_size: 100
	color: '#00000050'



## Register
Project.register!

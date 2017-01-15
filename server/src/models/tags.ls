require! 'keystone'


##
const types = keystone.Field.Types

const Tag = new keystone.List 'Tag',
	default-sort: 'name'

Tag.add do
	name        : type: String                                                        , required: yes, index: yes
	state       : type: types.Select, options: 'enabled, disabled', default: 'enabled', required: yes, index: yes
	url         : type: types.Url                                                                    , index: yes, initial: yes

Tag.default-columns = 'name, state, url'


## Register
Tag.register!

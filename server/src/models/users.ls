require! 'keystone'

const types = keystone.Field.Types

User = new keystone.List 'User'

User.add do
	name               : type: types.Name    ,               required: yes, index: yes
	email              : type: types.Email   , initial: yes, required: yes, index: yes
	password           : type: types.Password, initial: yes
	can-access-keystone: type: Boolean       , initial: yes


User.register!

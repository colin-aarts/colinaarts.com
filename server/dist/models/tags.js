// Generated by LiveScript 1.5.0
(function(){
  var keystone, types, Tag;
  keystone = require('keystone');
  types = keystone.Field.Types;
  Tag = new keystone.List('Tag', {
    defaultSort: 'name'
  });
  Tag.add({
    name: {
      type: String,
      required: true,
      index: true
    },
    state: {
      type: types.Select,
      options: 'enabled, disabled',
      'default': 'enabled',
      required: true,
      index: true
    },
    url: {
      type: types.Url,
      index: true,
      initial: true
    }
  });
  Tag.defaultColumns = 'name, state, url';
  Tag.register();
}).call(this);

//# sourceMappingURL=tags.js.map

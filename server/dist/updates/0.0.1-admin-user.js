var keystone = require('keystone'),
    User = keystone.list('User');

exports = module.exports = function(done) {

    new User.model({
        name: { first: 'Colin', last: 'Aarts' },
        email: 'colin@colinaarts.com',
        password: 'abc123',
        canAccessKeystone: true
    }).save(done);

};

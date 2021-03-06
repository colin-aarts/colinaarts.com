// Generated by LiveScript 1.5.0
(function(){
  var keystone;
  keystone = require('keystone');
  exports.initLocals = function(req, res, next){
    var locals;
    locals = res.locals;
    locals.user = req.user;
    return next();
  };
  exports.initErrorHandlers = function(req, res, next){
    res.err = function(err, title, message){
      console.log(err);
      return res.status(500).render('errors/500', {
        err: err,
        errorTitle: title,
        errorMsg: message
      });
    };
    res.notfound = function(title, message){
      return res.status(404).render('errors/404', {
        errorTitle: title,
        errorMsg: message
      });
    };
    return next();
  };
  exports.flashMessages = function(){};
}).call(this);

//# sourceMappingURL=middleware.js.map

// Generated by LiveScript 1.5.0
(function(){
  var keystone, middleware, ObjectId, routes;
  keystone = require('keystone');
  middleware = require('./middleware');
  ObjectId = keystone.mongoose.Types.ObjectId;
  keystone.pre('routes', middleware.initErrorHandlers);
  keystone.pre('routes', middleware.initLocals);
  keystone.pre('render', middleware.flashMessages);
  keystone.set('404', function(req, res, next){
    return res.notfound();
  });
  keystone.set('500', function(err, req, res, next){
    var title, message;
    title = undefined;
    if (err instanceof Error) {
      message = err.message;
      err = err.stack;
    }
    return res.err(err, title, message);
  });
  routes = {
    views: {
      index: function(req, res, next){
        var tpl, view;
        tpl = require('~/server/dist/templates/layouts/main.marko');
        view = new keystone.View(req, res);
        return res.marko(tpl);
      },
      api: {
        /*
        ** Article listing
        */
        articles: function(req, res, next){
          var Post, query, ids, objectIds;
          Post = keystone.list('Post');
          query = Post.model;
          ids = req.query.ids;
          if (ids) {
            ids = [].concat(ids);
            objectIds = ids.map(function(it){
              return keystone.mongoose.Types.ObjectId(it);
            });
            query = query.find({
              _id: {
                $in: ids
              }
            });
          } else {
            query = query.find();
          }
          return query.where('state', 'published').where('type', 'article').populate('author', '-password').sort('-publishedAt').exec(function(error, posts){
            if (error) {
              return res.send({
                error: error
              });
            } else {
              return res.send({
                error: null,
                count: posts.length,
                result: posts
              });
            }
          });
        }
        /*
        ** Article
        */,
        article: function(req, res, next){
          var slugOrId, Post, isId, item;
          slugOrId = req.params.slug;
          Post = keystone.list('Post');
          isId = isValidId(slugOrId);
          item = isId
            ? Post.model.findById(slugOrId)
            : Post.model.findOne({
              slug: slugOrId
            });
          return item.populate('author', '-password').exec(function(error, post){
            if (error) {
              return res.send({
                error: error
              });
            } else {
              return res.send({
                error: null,
                count: post ? 1 : 0,
                result: post
              });
            }
          });
        }
        /*
        ** Project listing
        */,
        projects: function(req, res, next){
          var Project, query, ids, objectIds;
          Project = keystone.list('Project');
          query = Project.model;
          ids = req.query.ids;
          if (ids) {
            ids = [].concat(ids);
            objectIds = ids.map(function(it){
              return keystone.mongoose.Types.ObjectId(it);
            });
            query = query.find({
              _id: {
                $in: ids
              }
            });
          } else {
            query = query.find();
          }
          return query.find().where('state', 'published').populate('tags').sort('-publishedAt').exec(function(error, projects){
            if (error) {
              return res.send({
                error: error
              });
            } else {
              return res.send({
                error: null,
                count: projects.length,
                result: projects
              });
            }
          });
        }
        /*
        ** Project
        */,
        project: function(req, res, next){
          var slugOrId, Project, isId, item;
          slugOrId = req.params.slug;
          Project = keystone.list('Project');
          isId = isValidId(slugOrId);
          item = isId
            ? Project.model.findById(slugOrId)
            : Project.model.findOne({
              slug: slugOrId
            });
          return item.populate('tags').exec(function(error, project){
            if (error) {
              return res.send({
                error: error
              });
            } else {
              return res.send({
                error: null,
                count: project ? 1 : 0,
                result: project
              });
            }
          });
        }
        /*
        ** Tag listing
        */,
        tags: function(req, res, next){
          var Tag;
          Tag = keystone.list('Tag');
          return Tag.model.find().where('state', 'enabled').sort('name').exec(function(error, tags){
            if (error) {
              return res.send({
                error: error
              });
            } else {
              return res.send({
                error: null,
                count: tags.length,
                result: tags
              });
            }
          });
        }
      }
    }
  };
  module.exports = function(app){
    app.all('/api/*', keystone.middleware.cors);
    app.options('/api/*', function(req, res){
      return res.send(200);
    });
    app.get('/api/posts', routes.views.api.articles);
    app.get('/api/posts/:slug', routes.views.api.article);
    app.get('/api/projects', routes.views.api.projects);
    app.get('/api/projects/:slug', routes.views.api.project);
    app.get('/api/tags', routes.views.api.tags);
    return app.get('/*', routes.views.index);
  };
  function isValidId(slugOrId){
    try {
      if (slugOrId === new ObjectId(slugOrId).toString()) {
        return true;
      } else {
        return false;
      }
    } catch (e$) {}
  }
}).call(this);

//# sourceMappingURL=index.js.map

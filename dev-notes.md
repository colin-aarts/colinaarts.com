* Patch `node_modules/marko/express.js`, line 2: `var express = module.parent.require('keystone').express;`
* WebPack: `.\node_modules\.bin\webpack.cmd -wd --config .\client\webpack.config.ls` — or —
* WebPack Dev Server w/ Hot Reload: `.\node_modules\.bin\webpack-dev-server.cmd --hot --config .\client\webpack.config.ls`. Supply own SSL certs if built-ins are broken again…
* Server LiveScript: `lsc -m linked -cwo server/dist server/src`
* Keystone server: `supervisor -w server/dist/public/app.js server/dist/app` for watching just the bundle, or `supervisor -w server/dist/app` to watch all changes, but this conflicts with how marko works. Need to exclude watching .marko.js files for that, but supervisor won't allow that, so maybe switch to nodemon.
* MongoDB: `mongod --dbpath d:\MongoDB\data\db\`

//  server.js

let express = require('express');
let bodyParser = require("body-parser");
let morgan = require('morgan');
const passport = require('passport')

module.exports.start = (options) => {

  return new Promise((resolve, reject) => {

    //  Make sure we have a repository and port provided.
    if(!options.repository) throw new Error("A server must be started with a connected repository.");
    if(!options.port) throw new Error("A server must be started with a port.");

    //  Create the app, add some logging.
    let app = express();
    app.use(bodyParser.urlencoded({ extended: false }));
    app.use(bodyParser.json());
    app.use(morgan('dev'));
    app.use(require('cookie-parser')());
    app.use(require('express-session')({ secret: 'keyboard cat', resave: true, saveUninitialized: true }));
    app.use(passport.initialize());
    app.use(passport.session());

    //  Add the APIs to the app.
    require('../api/user')(app, passport, options);
    require('../api/matching')(app, passport, options);

    //  Start the app, creating a running server which we return.
    let server = app.listen(options.port, () => {
      resolve(server);
    });

  });
};
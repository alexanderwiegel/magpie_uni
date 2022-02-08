const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
const expressJwt = require('express-jwt');
const config = require('./config');
const sqlManager = require('./sql');
const router = require('./user');
const morgan = require('morgan');
const http = require('http');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

app.use(morgan('dev'));



// use JWT auth to secure the api
app.use(jwt());


sqlManager.connectDB(function (err) {
  if (err) {
    throw err;
  }
  console.log("Database connected");
  // api routes
  app.use('/user', require('./user.js'));
  app.use('/nest', require('./nest.js'))
  app.use('/feed', require('./feed.js'))

  app.get("/", (req, resp) => {
    resp.send("working");
  });

});

// global error handler
app.use(errorHandler);

var server = http.createServer(app);


server.listen(3000, function () {
  console.log("Express server listening on port 3000");
});


function jwt() {
  const secret = config.jwtSecret;
  return expressJwt({ secret, algorithms: ['HS256'] }).unless({
    path: [
      '/user/login',
      '/user/register',
      '/nest/addNest',
      /\/uploads*/
    ]
  });
}

function errorHandler(err, req, res, next) {
  if (err.name === 'UnauthorizedError') {
    // jwt authentication error
    return res.status(401).json({ message: 'Invalid Token' });
  }
  // default to 500 server error
  return res.status(500).json({ message: err.message });
}


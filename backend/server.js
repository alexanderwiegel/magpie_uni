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
const { json } = require('body-parser');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

app.use("/uploads", express.static("uploads"));
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
  app.use('/nest', require('./nest.js'));
  app.use('/feed', require('./feed.js'));
  app.use('/chat', require('./chat.js'));

  app.get("/", (req, resp) => {
    resp.send("working");
  });

});

// global error handler
app.use(errorHandler);

var server = http.createServer(app);

const io = require('socket.io')(server, {
  cors: {
    origin: "localhost:3000",
    methods: ["GET", "POST"],
    withCredentials: false
  }
});

// message ,
//   date ,
//   sender_id ,
//   receiver_id ,
//   chat_session_id,
//   is_read

io.on('connection', socket => {
  console.log('hello world im a hot socket');
  socket.on('send_message', data => {
    console.log('UPDATED FROM MOBILE');
    sqlManager.insertChat(data, function (err, result) {
      if (err) {
        return;
      }
      console.log("message added to db");
      io.emit('receive_message', data);
    });
    // io.emit('receive_message', data);
  });
  socket.on('disconnect', () => { console.log('im disconnect'); });
});


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
      '/nest/addNestItem',
      '/nest/editNest',
      '/nest/editNestItem',
      /\/uploads*/,
      '/nest/userNests',
      '/nest/nestItems',
      '/nest/deleteNest',
      '/nest/deleteNestItem',
      '/user/getUser',
      '/user/userProfile',
      '/user/editUser',
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


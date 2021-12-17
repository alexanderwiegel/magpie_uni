const { O_NOFOLLOW } = require('constants');
const mysql = require('mysql');

config = mysql.c

var connection

// if(!process.env.dbPath) {
    //  if(false) {
   connection = mysql.createConnection({
        host     : 'localhost',
        user     : 'root',
        password : '',
        database : 'MagPie',
        multipleStatements: true
    });


function connectDB(cb) {
    connection.connect(function (err) {
        cb(err)
    });
}

// User quries...
function registerUser(user, cb) {
    connection.query("INSERT INTO User(name,created,email,password) VALUES('" + user.name + "','" + "',NOW(),true,'" + user.email + "','" + user.password + "')", function (err, rows) {
        if (err) cb(err);
        else cb(undefined, rows);
    });
}

function getUser(email, cb) {
    connection.query("SELECT id,name,address,password,postalCode,userType,dob,dateAdded,isActive,email FROM User u WHERE u.email = '" + email + "'",
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}

function getUserofId(id, cb) {
    connection.query("SELECT id,name,address,postalCode,userType,dob,dateAdded,isActive,email FROM User u WHERE u.id = " + id,
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}

//Nest 
function getUserNests(id, cb) {
    connection.query("SELECT * FROM Nest n WHERE n.user_id = " + id,
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}

//Nest-Items for nest
function getNestItems(id, cb) {
    connection.query("SELECT * FROM NestItem n WHERE n.nest_id = " + id,
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}

//Specific Nest
function getNestItem(id, cb) {
    connection.query("SELECT * FROM NestItem n WHERE n.id = " + id,
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}

//Feeds
function getFeeds(id, item, pageNum, cb) {
    connection.query("SELECT * FROM NestItem n WHERE n.user_id != " + id + " AND n.is_public = true",
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}


//Feed users nests
function getFeedUserNests(id, cb) {
    connection.query("SELECT * FROM Nest n WHERE n.user_id = " + id + " AND n.is_public = true",
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}

//Feed users nest items
function getFeedUserNestItems(id, cb) {
    connection.query("SELECT * FROM NestItem n WHERE n.nest_id = " + id + " AND n.is_public = true",
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}

//Feed users nest items
function getFeedUserNestItem(id, cb) {
    connection.query("SELECT * FROM NestItem n WHERE n.id = " + id + " AND n.is_public = true",
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}


module.exports = {
    connectDB: connectDB,
    registerUser: registerUser,
    getUser: getUser,
    getUserofId: getUserofId,
    getUserNests: getUserNests,
    getNestItems: getNestItems,
    getNestItem: getNestItem,
    getFeeds: getFeeds,
    getFeedUserNests: getFeedUserNests,
    getFeedUserNestItems: getFeedUserNestItems,
    getFeedUserNestItem: getFeedUserNestItem
}

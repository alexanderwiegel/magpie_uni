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

module.exports = {
    connectDB: connectDB,
    registerUser: registerUser,
    getUser: getUser,
    getUserofId: getUserofId,
}

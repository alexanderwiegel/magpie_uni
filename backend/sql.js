const { O_NOFOLLOW } = require('constants');
const { query } = require('express');
const mysql = require('mysql');

config = mysql.c

var connection

// if(!process.env.dbPath) {
    //  if(false) {
   connection = mysql.createConnection({
        host     : 'localhost',
        user     : 'root',
        password : 'MagPie_Team3',
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
    connection.query("INSERT INTO User (username,created_at,email,password) VALUES('" + user.name + "',NOW(),'" + user.email + "','" + user.password + "')", function (err, rows) {
        if (err) cb(err);
        else cb(undefined, rows);
    });
}

function getUser(email, cb) {
    connection.query("SELECT id,username,password,email,created_at,sort_mode,only_favored,is_asc,photo,phone_number FROM User u WHERE u.email = '" + email + "'",
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}

function getUserofId(id, cb) {
    connection.query("SELECT id,username,email,created_at FROM User u WHERE u.id = " + id,
        function (err, rows) {
            if (err) cb(err);
            else cb(undefined, rows);
        });
}

//Add new Nest
function addNest(nest, cb) {
    connection.query("INSERT INTO Nest (name,description,favored,user_id,photo,created_at) VALUES('" + nest.name + "','" + nest.description + "',0," + nest.user_id + ",'" + nest.photo + "',NOW())", function (err, rows) {
        if (err) cb(err);
        else cb(undefined, rows);
    });
} 

//Edit Nest
function editNest(nest, cb) {
    var query = "UPDATE Nest SET name = '" + nest.name + "', description = '" + nest.description + "' ,favored = " + nest.favored;
    if (nest.photo !== undefined) {
        query += ", photo ='" + nest.photo + "'";
    }
    query += "where id = " + nest.id;
    console.log(query);

    connection.query(query , function (err, rows) {
        if (err) cb(err);
        else cb(undefined, rows);
    });
} 

//Delete Nest
function deleteNest(nestID, cb) {
    connection.query("DELETE n.*, ni.* FROM Nest n, NestItem ni WHERE ni.nest_id = n.id AND n.id =" + nestID , function (err, rows) {
        if (err) cb(err);
        else cb(undefined, rows);
    });
}

//func update Nest Worth
function updateNestWorth(id) {
    var query = "UPDATE Nest n set n.total_worth = ( SELECT SUM(ni.worth) from NestItem ni WHERE ni.nest_id = "+ id +") WHERE n.id = " + id;
    connection.query( query , function (err, rows) {
        if (err) console.log(err);
        else console.log("success fully update worth for nest_id"+id);
    });
}

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

//Add NestItem
function addNestItem(nestItem, cb) {
    connection.query("INSERT INTO NestItem (name,description,favored,worth,user_id,nest_id,photo,created_at) VALUES('" + nestItem.name + "','" + nestItem.description + "',0," + nestItem.worth + "," + nestItem.user_id + "," + nestItem.nest_id + ",'" + nestItem.photo + "',NOW())", function (err, rows) {
        if (err) cb(err);
        else {
            updateNestWorth(nestItem.nest_id)
            cb(undefined, rows);
        }
    });
} 

//Edit Nest item
function editNestItem(nestItem, cb) {
    var query = "UPDATE NestItem SET name = '" + nestItem.name + "', description = '" + nestItem.description + "',favored = " + nestItem.favored + ",worth = " + nestItem.worth + ", is_public = " + nestItem.is_public;
    if (nestItem.photo !== undefined) {
        query += ", photo = '" + nestItem.photo  + "'";
    }
    query += " where id = " + nestItem.id;
    console.log(query);

    connection.query(query, function (err, rows) {
        if (err) cb(err);
        else {
            updateNestWorth(nestItem.nest_id)
            cb(undefined, rows);
        }
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
    addNest: addNest,
    editNest: editNest,
    deleteNest: deleteNest,
    getUserNests: getUserNests,
    getNestItems: getNestItems,
    getNestItem: getNestItem,
    addNestItem: addNestItem,
    editNestItem: editNestItem,
    getFeeds: getFeeds,
    getFeedUserNests: getFeedUserNests,
    getFeedUserNestItems: getFeedUserNestItems,
    getFeedUserNestItem: getFeedUserNestItem
}

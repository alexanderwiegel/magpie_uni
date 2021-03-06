const mysql = require('mysql');

config = mysql.c

var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'Magpie',
  multipleStatements: true,
});


function connectDB(cb) {
  connection.connect(function (err) {
    cb(err)
  });
}

// User quries...
function registerUser(user, cb) {
  connection.query("INSERT INTO user (username,created_at,email,password) VALUES('" + user.name + "',NOW(),'" + user.email + "','" + user.password + "')", function (err, rows) {
    if (err) cb(err);
    else cb(undefined, rows);
  });
}

function loginUser(email, cb) {
  connection.query("SELECT id,username,password,email,created_at,sort_mode,only_favored,is_asc,photo,phone_number FROM user u WHERE u.email = '" + email + "'",
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

function getUser(id, cb) {
  connection.query("SELECT sort_mode,only_favored,is_asc FROM user u WHERE u.id = '" + id + "'",
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

function editUser(body, cb) {
  console.log(`UPDATE user SET sort_mode="${body.sort_mode}", only_favored="${body.only_favored}", is_asc="${body.is_asc}" WHERE id = "${body.id}";`);
  connection.query(`UPDATE user SET sort_mode="${body.sort_mode}", only_favored="${body.only_favored}", is_asc="${body.is_asc}" WHERE id = "${body.id}";`,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

function getUserofId(id, cb) {
  connection.query("SELECT id,username,email,created_at FROM user u WHERE u.id = " + id,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}


function getUserProfile(id, cb) {
  var profileQuery = `SELECT u.username, u.photo, u.email,
                        (select count(*) as nestCount from nest where user_id = `+ id + `) as nestCount,
                        (select count(*) as nestItemCount from nestItem where user_id = `+ id + `) as nestItemCount
                        FROM user u WHERE u.id = `+ id + `;`;
  connection.query("SELECT n.* FROM nest n WHERE n.user_id = " + id + " ORDER BY n.created_at desc",
    function (err, rows) {
      if (err) cb(err);
      else {
        connection.query(profileQuery,
          function (err, profileRows) {
            if (err) cb(err);
            else cb(undefined, rows, profileRows);
          });
      }
    });
}


//Add new Nest
function addNest(nest, cb) {
  connection.query(`INSERT INTO nest (title,description,favored,is_public,user_id,photo,created_at) VALUES("` + nest.title + `","` + nest.description + `",0,` + nest.is_public + `,` + nest.user_id + `,'` + nest.photo + `',NOW())`, function (err, rows) {
    if (err) cb(err);
    else cb(undefined, rows);
  });
}

//Edit Nest
function editNest(nest, cb) {
  var query = `UPDATE nest SET title = "` + nest.title + `", description = "` + nest.description + `", favored = ` + nest.favored + `, is_public = ` + nest.is_public;
  if (nest.photo !== undefined) {
    query += `, photo ='` + nest.photo + `'`;
  }
  query += ` where id = ` + nest.id;
  console.log(query);

  connection.query(query, function (err, rows) {
    if (err) cb(err);
    else cb(undefined, rows);
  });
}

//Delete Nest
function deleteNest(nestID, cb) {
  var query = `DELETE FROM nestItem WHERE nestItem.nest_id = "${nestID}"; DELETE FROM nest WHERE nest.id = "${nestID}";`
  console.log(query);
  connection.query(query, function (err, rows) {
    if (err) cb(err);
    else cb(undefined, rows);
  });
}

//func update nest Worth
function updateNestWorth(id) {
  var query = "UPDATE nest n set n.total_worth = ( SELECT SUM(ni.worth) from nestItem ni WHERE ni.nest_id = " + id + ") WHERE n.id = " + id;
  connection.query(query, function (err, rows) {
    if (err) console.log(err);
    else console.log("success fully update worth for nest_id" + id);
  });
}

function getColumnToSortBy(sortMode, isNest) {
  var worthType = isNest ? "total_worth" : "worth";
  switch (sortMode) {
    case "SortMode.sortByName":
      return "title";
    case "SortMode.sortByWorth":
      return worthType;
    case "SortMode.sortByFavored":
      return "favored";
    case "SortMode.sortById":
      return "id";
    default:
      return "id";
  }
}

// TODO: apply EXACTLY the same for nest items
function getUserNests(id, sortMode, asc, onlyFavored, cb) {
  var query = `SELECT n.*, (SELECT COUNT(*) FROM nestItem ni WHERE n.id = ni.nest_id) as nestItemCount FROM nest n WHERE n.user_id = ` + id;
  console.log("onlyFavored: " + onlyFavored)
  if (onlyFavored == "true") query += " AND n.favored = 1";
  var sort = getColumnToSortBy(sortMode, true);
  console.log("Sort by: n." + sort);
  query += " ORDER BY n." + sort;
  var is_asc = asc == 'true' ? " ASC;" : " DESC;";
  console.log("asc inside query : " + asc);
  query += is_asc;
  console.log("Query " + query);

  connection.query(query,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

//Nest-Items for nest
function getNestItems(nestId, sortMode, asc, onlyFavored, cb) {
  var query = "SELECT * FROM nestItem n WHERE n.nest_id = " + nestId;
  if (onlyFavored == "true") query += " AND n.favored = 1";
  var sort = getColumnToSortBy(sortMode, false);
  console.log("Sort by: " + sort);
  query += " ORDER BY n." + sort;
  var is_asc = asc == 'true' ? " ASC;" : " DESC;";
  console.log("asc inside query : " + asc);
  query += is_asc;
  console.log("Query " + query);

  connection.query(query,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

function getStatistics(userId, cb) {
  var query = "SELECT COUNT(*) as count, created_at as date FROM nestItem ni WHERE ni.user_id = " + userId + " GROUP BY ni.created_at ORDER BY ni.created_at DESC;";
  connection.query(query,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

//getting all items from every nest of that user
function getAllNestItems(id, cb) {
  connection.query("SELECT * FROM nestItem n WHERE n.user_id = " + id,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

//Specific Nest Item
function getNestItem(id, cb) {
  connection.query("SELECT * FROM nestItem n WHERE n.id = " + id,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

//Add NestItem
function addNestItem(nestItem, cb) {
  connection.query(`INSERT INTO nestItem (title,description,favored,is_public,worth,user_id,nest_id,photo,created_at) VALUES("` + nestItem.title + `","` + nestItem.description + `",0,` + nestItem.is_public + `,` + nestItem.worth + `,` + nestItem.user_id + `,` + nestItem.nest_id + `,'` + nestItem.photo + `',NOW())`, function (err, rows) {
    if (err) cb(err);
    else {
      updateNestWorth(nestItem.nest_id)
      cb(undefined, rows);
    }
  });
}

//Edit nest item
function editNestItem(nestItem, cb) {
  var query = `UPDATE nestItem SET title = "` + nestItem.title + `", description = "` + nestItem.description + `",favored = ` + nestItem.favored + `,worth = ` + nestItem.worth + `, is_public = ` + nestItem.is_public;
  if (nestItem.photo !== undefined) {
    query += `, photo = '` + nestItem.photo + `'`;
  }
  query += ` where id = ` + nestItem.id;
  console.log(query);

  connection.query(query, function (err, rows) {
    if (err) cb(err);
    else {
      updateNestWorth(nestItem.nest_id)
      cb(undefined, rows);
    }
  });
}

//Delete Nest Item
function deleteNestItem(nestItemID, cb) {
  var query = "DELETE FROM nestItem WHERE id = " + nestItemID;
  console.log(query);
  connection.query(query, function (err, rows) {
    if (err) cb(err);
    else cb(undefined, rows);
  });
}

//Feeds
function getFeeds(id, item, pageNum, cb) {
  connection.query("SELECT ni.id, ni.title, ni.description, ni.user_id, ni.photo, ni.created_at, u.username, u.email FROM nestItem ni, user u WHERE ni.user_id <> " + id + " AND ni.is_public = true AND ni.user_id = u.id ORDER BY ni.created_at desc;",
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}


//Feed users nests
function getFeedUserProfile(id, cb) {
  var profileQuery = `SELECT u.username, u.photo, u.email,
                        (select count(*) as nestCount from nest where user_id = `+ id + ` AND is_public = true) as nestCount,
                        (select count(*) as nestItemCount from nestItem where user_id = `+ id + ` AND is_public = true) as nestItemCount
                        FROM user u WHERE u.id = `+ id + `;`;
  connection.query("SELECT n.id, n.title, n.description, n.photo, n.user_id FROM nest n WHERE n.user_id = " + id + " AND n.is_public = true ORDER BY n.created_at desc",
    function (err, rows) {
      if (err) cb(err);
      else {
        connection.query(profileQuery,
          function (err, profileRows) {
            if (err) cb(err);
            else cb(undefined, rows, profileRows);
          });
      }
    });
}

//Feed users nest items
function getFeedUserNestItems(id, cb) {
  connection.query("SELECT n.id, n.nest_id, n.user_id, n.title, n.description, n.photo FROM nestItem n WHERE n.user_id = " + id + " AND n.is_public = true",
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

//Feed users nest items
function getFeedUserNestItem(id, cb) {
  connection.query("SELECT * FROM nestItem n WHERE n.id = " + id + " AND n.is_public = true",
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}



/////////////////////////////////////////////CHAT////////////////////////////////////////////////
function getChatHistoryById(chatSessionId, loggedInUserId, cb) {
  var queryString = `SELECT c.*,
	U.username as opponentUserName,
    MU.username as myName
        FROM chat c
        inner join user U on (U.id = c.sender_id and c.sender_id <> `+ loggedInUserId + `) OR (U.id = c.receiver_id and c.receiver_id <>` + loggedInUserId + `)
        inner join user MU on (MU.id = c.sender_id and c.sender_id <> U.Id) OR (MU.id = c.receiver_id and c.receiver_id <> U.Id)
    WHERE chat_session_id = `+ chatSessionId + `
    ORDER BY date desc`;
  connection.query(queryString,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}


function getChatList(userId, cb) {
  var queryString = `
    SELECT
        CS.id,
        (select count(*) as totalCount from chat where ifnull(is_read, false) = false and receiver_id = `+ userId + ` and chat_session_id = CS.id) as unreadMessages,
        SUBSTRING(
                (SELECT
                    message as topMessage
                FROM chat tm
                WHERE ((tm.sender_id = CS.user1_id AND tm.receiver_id = CS.user2_id) OR (tm.sender_id = CS.user2_id AND tm.receiver_id = CS.user1_id))		
                AND tm.chat_session_id = CS.id
                ORDER BY tm.date DESC
                limit 1), 1, 50
            ) as topMessage,
            (SELECT
                date
            FROM chat tm
            WHERE ((tm.sender_id = CS.user1_id AND tm.receiver_id = CS.user2_id) OR (tm.sender_id = CS.user2_id AND tm.receiver_id = CS.user1_id))		
            AND tm.chat_session_id = CS.id
            ORDER BY tm.date DESC
            limit 1) as lastMessageTime,
            U.username as opponentUserName, U.id as opponentUserId
        FROM chatSession CS
        INNER JOIN user U on (U.id = CS.user1_id and CS.user1_id <> `+ userId + `) OR (U.id = CS.user2_id and CS.user2_id <> ` + userId + `)
        where (CS.user1_id = `+ userId + `) OR (CS.user2_id = ` + userId + `)
        order by CS.created_at desc`;
  connection.query(queryString,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

function checkAndInsertChatSession(currentUserId, opponentUserId, cb) {
  //body.message = body.message.replaceAll("'", "\'"); 
  // var query = `Select * from chatSession where (user1_id = ` + senderId + ` OR user1_id = ` + receiverId + `) AND (user2_id = ` + senderId + ` OR user2_id = ` + receiverId + `)`;
  var query = `SELECT
                CS.id,
                (select count(*) as totalCount from chat where ifnull(is_read, false) = false and receiver_id = `+ currentUserId + ` and chat_session_id = CS.id) as unreadMessages,
                SUBSTRING(
                        (SELECT
                            message
                        FROM chat tm
                        WHERE ((tm.sender_id = CS.user1_id AND tm.receiver_id = CS.user2_id) OR (tm.sender_id = CS.user2_id AND tm.receiver_id = CS.user1_id))		
                        AND tm.chat_session_id = CS.id
                        ORDER BY tm.date DESC
                        limit 1), 1, 50
                    ) AS topMessage,
                    U.username as opponentUserName, U.id as opponentUserId
                FROM chatSession CS
                INNER JOIN user U on (U.id = CS.user1_id and CS.user1_id <> `+ currentUserId + `) OR (U.id = CS.user2_id and CS.user2_id <> ` + currentUserId + `)
                where (user1_id = ` + currentUserId + ` OR user1_id = ` + opponentUserId + `) AND (user2_id = ` + currentUserId + ` OR user2_id = ` + opponentUserId + `)
                order by CS.created_at desc`;

  var insertChatSessionQuery = `INSERT INTO chatSession (user1_id, user2_id, created_by, created_at)
                                  VALUES (`+ currentUserId + `,` + opponentUserId + `,` + currentUserId + `,now())`;
  console.log(query);
  console.log(insertChatSessionQuery);
  // var queryString = `call CheckAndInsertChatSession(` + senderId + `, ` + receiverId + `)`;
  connection.query(query,
    function (err, rows) {
      if (err) cb(err);
      else {
        if (rows.length == 0) {
          connection.query(insertChatSessionQuery, function (err, rows) {
            if (err) cb(err);
            else {
              connection.query(query,
                function (err, rows) {
                  if (err) cb(err);
                  else cb(undefined, rows);
                });
            }
          });
        }
        else {
          cb(undefined, rows);
        }
      }
    });
}

function updateReadBit(chatSessionID, userId, cb) {
  //body.message = body.message.replaceAll("'", "\'");  
  var queryString = `update chat
        set is_read = true
        where receiver_id = `+ userId + ` and chat_session_id = ` + chatSessionID;

  connection.query(queryString,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}

function getNotification(userId, cb) {
  //body.message = body.message.replaceAll("'", "\'");  
  var queryString = `select count(*) as totalCount from chat
    where ifnull(is_read, false) = false
    and receiver_id = `+ userId;

  connection.query(queryString,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}


function insertChat(body, cb) {
  console.log("Chat body: " + body);

  //body.message = body.message.replaceAll("'", "\'");  
  var queryString = `INSERT INTO chat (message, date, sender_id, receiver_id, chat_session_id, is_read)
                        VALUES ('`+ body.message + `', now(), ` + body.sender_id + `, ` + body.receiver_id + `, ` + body.chat_session_id + `, false);`;
  console.log("Insert chat: " + queryString);
  connection.query(queryString,
    function (err, rows) {
      if (err) cb(err);
      else cb(undefined, rows);
    });
}



module.exports = {
  connectDB: connectDB,
  registerUser: registerUser,
  loginUser: loginUser,
  getUser: getUser,
  editUser: editUser,
  getUserofId: getUserofId,
  getUserProfile: getUserProfile,
  getStatistics: getStatistics,
  getAllNestItems: getAllNestItems,
  addNest: addNest,
  editNest: editNest,
  deleteNest: deleteNest,
  getUserNests: getUserNests,
  getNestItems: getNestItems,
  getNestItem: getNestItem,
  addNestItem: addNestItem,
  editNestItem: editNestItem,
  deleteNestItem: deleteNestItem,
  getFeeds: getFeeds,
  getFeedUserProfile: getFeedUserProfile,
  getFeedUserNestItems: getFeedUserNestItems,
  getFeedUserNestItem: getFeedUserNestItem,
  getChatHistoryById: getChatHistoryById,
  getChatList: getChatList,
  insertChat: insertChat,
  checkAndInsertChatSession: checkAndInsertChatSession,
  updateReadBit: updateReadBit,
  getNotification: getNotification
}

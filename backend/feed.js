const router = require('express').Router();
const sqlManager = require('./sql');
const config = require('./config');
const jwt = require('jsonwebtoken');
const moment = require('moment');

//get feeds
router.get('/getFeeds', async function(req, res) {
    let userID = req.query.userId;
    let items = req.query.items;
    let pageNo = req.query.page_num;

    console.log(userID);

    sqlManager.getFeeds(userID, items, pageNo, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        result.forEach(item => {
              item["created_at"] = moment(item["created_at"]).fromNow()
        });
        res.status(200).json({status: "Success", result: result});    
    });
});


//get Nests for user from Feed
router.get('/userProfile', async function(req, res) {
    let userID = req.query.userId;
    console.log(userID);

    sqlManager.getFeedUserProfile(userID, async function(err, result, profileResult) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        sqlManager.getFeedUserNestItems(userID, async function(err, nestItemsResult) {
            if (err) {
                res.status(500).json({status:'Failed', message: err.message});
                return
            }
            res.status(200).json({status: "Success", profile: profileResult[0], nests: result, nestItems: nestItemsResult});    
        })
    });
});


//get Nest Items for user from Feed
router.get('/nestItems', async function(req, res) {
    let nestID = req.query.nest_id;
    console.log(userID);

    sqlManager.getFeedUserNestItems(nestID, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({status: "Success", result: result});    
    });
});


// get specific nest item for Feed users
router.get('/nestItem', async function(req, res) {
    let nestItemID = req.query.nest_item_id;
    console.log(nestItemID);

    sqlManager.getFeedUserNestItem(nestItemID, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        if(result.length == 0) {
            res.status(200).json({status:'Failed', message:'Nest item doesnot exists.'});
        }
        else {
            res.status(200).json({status: "Success", result: result[0]});  
        }  
    });
});

module.exports = router
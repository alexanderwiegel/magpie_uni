const router = require('express').Router();
const sqlManager = require('./sql');
const config = require('./config');
const jwt = require('jsonwebtoken');

//get feeds
router.get('/', async function(req, res) {
    let userID = req.params.user_id;
    let items = req.params.items;
    let pageNo = req.params.page_num;

    console.log(userID);

    sqlManager.getFeeds(userID, items, pageNo, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({result: result});    
    });
});


//get Nests for user from Feed
router.get('/userNests', async function(req, res) {
    let userID = req.params.user_id;
    console.log(userID);

    sqlManager.getFeedUserNests(userID, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({result: result});    
    });
});


//get Nest Items for user from Feed
router.get('/nestItems', async function(req, res) {
    let nestID = req.params.nest_id;
    console.log(userID);

    sqlManager.getFeedUserNestItems(nestID, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({result: result});    
    });
});


// get specific nest item for Feed users
router.get('/nestItem', async function(req, res) {
    let nestItemID = req.params.nest_item_id;
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
            res.status(200).json({result: result[0]});  
        }  
    });
});

module.exports = router
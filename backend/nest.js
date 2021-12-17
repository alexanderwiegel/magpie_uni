const router = require('express').Router();
const sqlManager = require('./sql');
const config = require('./config');
const jwt = require('jsonwebtoken');


//get Nests for user
router.get('/userNests', async function(req, res) {
    let userID = req.params.user_id;
    console.log(userID);

    sqlManager.getUserNests(userID, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({result: result});    
    });
});


// get items for specific nest
router.get('/nestItems', async function(req, res) {
    let nestID = req.params.nest_id;
    console.log(nestID);

    sqlManager.getNestItems(nestID, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({result: result});    
    });
});


// get specific nest item
router.get('/nestItem', async function(req, res) {
    let nestItemID = req.params.nest_item_id;
    console.log(nestItemID);

    sqlManager.getNestItem(nestItemID, async function(err, result) {
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
const router = require('express').Router();
const sqlManager = require('./sql');
const config = require('./config');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const saltRounds = 10;


// Register User
router.post('/register', async function(req, res) {

    let textPass = req.body.password;
    let hashPass = await bcrypt.hash(textPass, saltRounds);
    console.log(hashPass);
    user = {
        email: req.body.email,
        password: hashPass,
        name: req.body.username
    }

    sqlManager.registerUser(user, function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({status:'Success', message:'User Succesfully Registered'});
    });

});


router.post('/login', async function(req, res) {

    let email = req.body.email;
    let password = req.body.password;

    if (!(email && password)) {
        res.status(400).json({message: "Email and password cannot be null."});
        return
    }

    // get user from User Table...
    sqlManager.getUser(email, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        
        if(result.length == 0) {
            res.status(200).json({status:'Failed', message:'Login Failed. Username or Password incorrect.'});
        }
        else {
            
            let match = await bcrypt.compare(password, result[0].password);            

            console.log(password, result[0].password, match, bcrypt.compareSync(password, result[0].password));
            if(!match) {
                res.status(400).json({status:'Failed', message:'Incorrect Password.'});
                return
            }

            delete result[0].password;
            const token = jwt.sign({ user: result[0].id }, config.jwtSecret, { expiresIn: '1h' });
            res.status(200).json({status:'Success', message:'Login Success', token: token, user: result[0]});    
        }
    });

});


router.get('/userProfile', async function(req, res) {
    let userID = req.query.userId;
    console.log(userID);

    sqlManager.getUserProfile(userID, async function(err, result, profileResult) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        sqlManager.getAllNestItems(userID, async function(err, nestItemsResult) {
            if (err) {
                res.status(500).json({status:'Failed', message: err.message});
                return
            }
            res.status(200).json({status: "Success", profile: profileResult[0], nests: result, nestItems: nestItemsResult});    
        })
    });
});

module.exports = router
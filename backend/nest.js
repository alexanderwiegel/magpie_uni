const router = require('express').Router();
const sqlManager = require('./sql');
const config = require('./config');
const jwt = require('jsonwebtoken');
const multer  = require('multer');
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'uploads/')
    },
    filename: function (req, file, cb) {
      cb(null, file.originalname)
    }
  });
const upload = multer({storage: storage});


//Add new Nest
router.post('/addNest', upload.array('image',1), async function(req, res) {
    var photo = "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png";
    if(req.files && req.files.length > 0) {
        photo = req.files[0].path;
    }
    nest = {
        name: req.body.name,
        description: req.body.description,
        user_id: req.body.user_id,
        photo: photo
    }

    sqlManager.addNest(nest, function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({status:'Success', message:'Nest Added Succesfully'});
    });
})

router.put('/editNest', upload.array('image',1), async function(req, res) {
    
    nest = {
        id : req.body.id,
        name: req.body.name,
        description: req.body.description,
        favored: req.body.favored ?? 0
    }

    if(req.files && req.files.length > 0) {
        nest.photo = req.files[0].path;
    }

    sqlManager.editNest(nest, function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({status:'Success', message:'Nest Edited Succesfully'});
    });
})

//delete Nest
router.delete('/deleteNest', async function(req, res) {
    let nestID = req.body.nest_id;
    console.log(nestID);
    sqlManager.deleteNest(nestID, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({result: result});    
    });
})


//get Nests for user
router.get('/userNests', async function(req, res) {
    let userID = req.query.user_id;
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
    let nestID = req.query.nest_id;
    console.log(nestID);

    sqlManager.getNestItems(nestID, async function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({result: result});    
    });
});

//Add nest item
router.post('/addNestItem', upload.array('image',1), async function(req, res) {
    var photo = "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png";
    if(req.files && req.files.length > 0) {
        photo = req.files[0].path;
    }
    nestItem = {
        name: req.body.name,
        description: req.body.description,
        user_id: req.body.user_id,
        nest_id: req.body.nest_id,
        worth: req.body.worth,
        photo: photo,
        is_public: req.body.is_public
    }

    sqlManager.addNestItem(nestItem, function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({status:'Success', message:'Nest Item Added Succesfully'});
    });
})


//Edit nest item
router.put('/editNestItem', upload.array('image',1), async function(req, res) {
    
    nestItem = {
        id: req.body.id,
        name: req.body.name,
        description: req.body.description,
        worth: req.body.worth,
        is_public: req.body.is_public ?? 0,
        favored: req.body.favored ?? 0,
        nest_id: req.body.nest_id ?? -1
    }
    
    if(req.files && req.files.length > 0) {
        nesItem.photo = req.files[0].path;
    }

    sqlManager.editNestItem(nestItem, function(err, result) {
        if (err) {
            res.status(500).json({status:'Failed', message: err.message});
            return
        }
        res.status(200).json({status:'Success', message:'Nest Item Edited Succesfully'});
    });
})

// get specific nest item
router.get('/nestItem', async function(req, res) {
    let nestItemID = req.query.nest_item_id;
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

module.exports = router
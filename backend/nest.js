const router = require('express').Router();
const sqlManager = require('./sql');
const imageCompareManager = require('./compareImages');
const multer  = require('multer');
const { json } = require('express');
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
        photo = encodeURI(req.files[0].path);
    }
    nest = {
        title: req.body.name,
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
        title: req.body.name,
        description: req.body.description,
        favored: req.body.favored ?? 0
    }

    if(req.files && req.files.length > 0) {
        nest.photo = encodeURI(req.files[0].path);
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
        photo = encodeURI(req.files[0].path);
        console.log(photo);
        // if (req.body.compare != undefined && req.body.compare) {
            // data = { 
            //     originalImage: req.files[0].path,
            //     userId: req.body.user_id
            // }
        //     console.log("Calling Image comaprision");
        //     await imageCompareManager.compare(data, async function(err, result) {
        //         console.log("Image comaprision callback received");

        //         if (err) {
        //             console.log(err);
        //         }
        //         else {
        //             console.log("Image comaprision callback else condition");
        //             console.log(result.length);
        //             if (result.length != 0) {
        //                 console.log("Image comaprision callback length is greater than 0");
        //                 res.status(200).json({status:'Similar items found in your collections.', items: result});
        //             }
        //         }
        //     });
        // }
    }

    var compare = (req.body.compare === 'true');
    var data = { 
        originalImage: req.files.length > 0 ? req.files[0].path : undefined,
        userId: req.body.user_id,
        compare: compare
    }
    
    console.log(req.body);
    console.log(data);

    imageCompareManager.compare(data)
    .then ( result =>  {
        console.log("Inside then");
        if (result.length != 0) {
            console.log("Image comaprision callback length is greater than 0");
            res.status(200).json({status:'Similar items found in your collections.', items: result});
        }
        else {
            console.log("Image comaprision callback length is 0");
            nestItem = {
                title: req.body.name,
                description: req.body.description,
                user_id: req.body.user_id,
                nest_id: req.body.nest_id,
                worth: req.body.worth,
                photo: photo,
                is_public: req.body.is_public
            }
        
            console.log("calling add nest item");
            sqlManager.addNestItem(nestItem, function(err, result) {
                console.log("callback add nest item");
                if (err) {
                    res.status(500).json({status:'Failed', message: err.message});
                    return
                }
                res.status(200).json({status:'Success', message:'Nest Item Added Succesfully'});
            });
        }
    })
    .catch( e => {
        res.status(500).json({status:'Failed', message: e.message});
    });
    // console.log("COntinuing with add flow");



    // nestItem = {
    //     title: req.body.name,
    //     description: req.body.description,
    //     user_id: req.body.user_id,
    //     nest_id: req.body.nest_id,
    //     worth: req.body.worth,
    //     photo: photo,
    //     is_public: req.body.is_public
    // }

    // console.log("calling add nest item");
    // sqlManager.addNestItem(nestItem, function(err, result) {
    //     console.log("callback add nest item");
    //     if (err) {
    //         res.status(500).json({status:'Failed', message: err.message});
    //         return
    //     }
    //     res.status(200).json({status:'Success', message:'Nest Item Added Succesfully'});
    // });
})


//Edit nest item
router.put('/editNestItem', upload.array('image',1), async function(req, res) {
    
    nestItem = {
        id: req.body.id,
        title: req.body.name,
        description: req.body.description,
        worth: req.body.worth,
        is_public: req.body.is_public ?? 0,
        favored: req.body.favored ?? 0,
        nest_id: req.body.nest_id ?? -1
    }
    
    if(req.files && req.files.length > 0) {
        nesItem.photo = encodeURI(req.files[0].path);
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
const Jimp = require("jimp");
const sqlManager = require('./sql');

async function compare(body) {
  return new Promise(async (resolve, reject) => {
    if (!body.compare || body.originalImage === undefined) {
      return resolve([]);
    }
    console.log("Comparision funcion");
    console.log("./" + body.originalImage);
    var filePath = "./" + body.originalImage;
    const original = await Jimp.read(filePath);
    sqlManager.getAllNestItems(body.userId, async function (err, nestItemsResult) {
      console.log("getAllNestItems callback received");
      if (err) {
        reject(err);
        return
      }
      var similarItems = [];
      console.log("Starting to compare callback images");
      await Promise.all(nestItemsResult.map(async (nestItem) => {
        if (nestItem.photo != "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png") {
          var filePath = "./" + decodeURI(nestItem.photo);
          var image = await Jimp.read(filePath);
          var distance = Jimp.distance(original, image);
          var diff = Jimp.diff(original, image).percent;
          console.log("Images compared to ", filePath);
          console.log(`distance       ${diff}`);
          console.log(`diff.percent   ${diff}\n`);

                    if (distance <= 0.15 && diff <= 0.40) {
                        console.log(similarItems.length);
                        similarItems.push(nestItem);
                    }
                }
            }));
            console.log("sending comaprision call back");
            resolve (similarItems);    
        });
    });
}



module.exports = {
    compare: compare
}
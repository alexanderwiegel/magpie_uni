const router = require("express").Router();
const sqlManager = require("./sql");
const moment = require('moment');

router.get("/getChatHistoryById", function (req, res) {
  console.log(req);
  sqlManager.getChatHistoryById(
    req.query.chatSessionId,
    req.query.userId,
    function (err, result) {
      if (err) {
        res.status(500).json({ status: "Failed", message: err.message });
        return;
      }
      if (result.length == 0) {
        res.status(200).json({ status: "Success", chat: [] });
        return;
      }
      res.status(200).json({ status: "Success", chat: result });
    }
  );
});

router.get("/getChatList", function (req, res) {
  console.log(req);
  sqlManager.getChatList(req.query.userId, function (err, result) {
    if (err) {
      res.status(500).json({ status: "Failed", message: err.message });
      return;
    }
    if (result.length == 0) {
      res.status(200).json({ status: "Success", chat: [] });
      return;
    }
    console.log(result);
    result.forEach(item => {
      if (item["lastMessageTime"] != null) {
        item["lastMessageTime"] = moment(item["lastMessageTime"]).fromNow()
      }
    });
    console.log(result);
    res.status(200).json({ status: "Success", chat: result });
  });
});

router.get("/checkAndInsertChatSession", function (req, res) {
  console.log(req.body);

  sqlManager.checkAndInsertChatSession(
    req.query.currentUserId,
    req.query.opponentUserId,
    function (err, result) {
      if (err) {
        res.status(500).json({ status: "Failed", message: err.message });
        return;
      }
      if (result.length == 0) {
        res.status(200).json({ status: "Success", chat: {} });
        return;
      }
      res.status(200).json({ status: "Success", chat: result[0] });
    }
  );
});

router.get("/updateReadBit", function (req, res) {
  console.log(req.body);

  sqlManager.updateReadBit(
    req.query.chatSessionId,
    req.query.userId,
    function (err, result) {
      if (err) {
        res.status(500).json({ status: "Failed", message: err.message });
        return;
      }
      res.status(200).json({ status: "Success" });
    }
  );
});

router.get("/getNotification", function (req, res) {
  console.log(req.body);

  sqlManager.getNotification(req.query.userId, function (err, result) {
    if (err) {
      res.status(500).json({ status: "Failed", message: err.message });
      return;
    }

    if (result.length == 0) {
      res.status(200).json({ status: "Success", chat: {} });
      return;
    }

    res.status(200).json({ status: "Success", chat: result });
  });
});

router.post("/insertChat", function (req, res) {
  console.log("huzaifa");
  console.log(req.body);

  sqlManager.insertChat(req.body, function (err, result) {
    if (err) {
      res.status(500).json({ status: "Failed", message: err.message });
      return;
    }
    if (result.length == 0) {
      res.status(404).json({ status: "Success" });
      return;
    }
    res.status(200).json({ status: "Success" });
  });
});

module.exports = router;

const express = require("express");
const Tweet = require("../models/tweet");
const auth = require("../middleware/auth");
const multer = require("multer");
const sharp = require("sharp");

const router = new express.Router();

// Post a tweet
router.post("/tweets", auth, async (req, res) => {
  const tweet = new Tweet({
    ...req.body,
    userId: req.user.id,
    userName: req.user.userName,
  });

  try {
    await tweet.save();
    res.status(201).send(tweet);
  } catch (e) {
    return res.status(500).send({ error: e.message });
  }
});

// get all tweets
router.get("/tweets", async (req, res) => {
  try {
    const allTweets = await Tweet.find({});

    return res.status(200).json(allTweets);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// upload images in a tweet
const upload = multer({
  limits: {
    fileSize: 100000000,
  },
});

router.post(
  "/upload-tweet-image/:id",
  auth,
  upload.single("picture"),
  async (req, res) => {
    try {
      const tweet = await Tweet.findOne({ _id: req.params.id });
      if (!tweet) {
        return res.status(404).send({ error: "Cannot find tweet" });
      }
      const buffer = await sharp(req.file.buffer)
        .resize({ width: 350, height: 350 })
        .png()
        .toBuffer();
      tweet.image = buffer;
      await tweet.save();
      return res.status(200).send("Image uploaded");
    } catch (e) {
      return res.status(500).send(e);
    }
  }
);
// Fetch tweet image
router.get("/tweets/:id/image", async (req, res) => {
  try {
    const tweet = await Tweet.findById(req.param.sid);
    if (!tweet || !tweet.image) {
      return res.status(404).send({ error: "Tweet image doesn't exist" });
    }
    res.set("Content-Type", "image/jpg");
    res.send(tweet.image);
  } catch (e) {
    return res.status(500).send(e);
  }
});

module.exports = router;

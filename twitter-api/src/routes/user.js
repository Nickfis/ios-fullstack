const express = require("express");
const User = require("../models/user");
const multer = require("multer");
const sharp = require("sharp");
const auth = require("../middleware/auth");

const router = new express.Router();

const upload = multer({
  limits: {
    fileSize: 1000000,
  },
});

router.post("/users", async (req, res) => {
  const user = new User(req.body);
  try {
    await user.save();
    res.status(201).send(user);
  } catch (e) {
    res.status(400).send(e);
  }
});

router.get("/users", async (req, res) => {
  try {
    const users = await User.find({});
    res.send(users);
  } catch (e) {
    res.status(500).send(e);
  }
});

// Get an individual user
router.get("/users:/id", async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).send("User not found");
    }
    res.send(user);
  } catch (e) {
    res.status(500).send(e);
  }
});

router.post("/users/login", async (req, res) => {
  try {
    const user = await User.findByCredentials(
      req.body.email,
      req.body.password
    );
    const token = await user.generateAuthToken();
    res.send({ user, token });
  } catch (e) {
    res.status(500).send({ error: e.message });
  }
});

router.delete("/users/:id", async (req, res) => {
  try {
    const user = await User.findByIdAndDelete(req.params.id);
    if (!user) {
      return res.status(400).send("User not found");
    }
    res.status(200).send({ message: "User has been deleted" });
  } catch (e) {
    return res.status(500).send(e);
  }
});

// Post User Profile Image
router.post(
  "/users/me/avatar",
  auth,
  upload.single("avatar"),
  async (req, res) => {
    try {
      const buffer = await sharp(req.file.buffer)
        .resize({ width: 250, height: 250 })
        .png()
        .toBuffer();

      if (req.user.avatar) {
        req.user.avatar = null;
        req.user.avatarExists = false;
      }

      req.user.avatar = buffer;
      req.user.avatarExists = true;
      await req.user.save();

      res.send();
    } catch (e) {
      res.status(400).send({ error: e.message });
    }
  }
);

// Fetch user profile image
router.get("/users/:id/avatar", async (req, res) => {
  try {
    const user = await User.findById(req.params.id);

    if (!user || !user.avatar) {
      throw new Error("User does not exist or profile picture not available");
    }

    res.set("Content-Type", "image/jpg");
    res.send(user.avatar);
  } catch (e) {
    res.status(400).send(e);
  }
});

// Route for following
router.put("/users/:id/follow", auth, async (req, res) => {
  console.log(req.user.id);
  if (req.user.id === req.params.id) {
    return res.status(400).send({ error: "can't follow yourself" });
  }

  try {
    const user = await User.findById(req.params.id);
    if (!user.followers.includes(req.user.id)) {
      await user.updateOne({ $push: { followers: req.user.id } });
      await req.user.updateOne({ $push: { followings: req.params.id } });
      res.status(200).json("User has been followed");
    } else {
      res.status(400).send("You already follow this user");
    }
  } catch (e) {
    return res.status(500).send({ error: e.message });
  }
});

router.put("/users/:id/unfollow", auth, async (req, res) => {
  if (req.user.id == req.params.id) {
    return res.status(400).send({ error: "can't unfollow yourself" });
  }

  try {
    const user = await User.findById(req.params.id);
    if (user.followers.includes(req.user.id)) {
      user.followers = user.followers.filter(
        (follower) => follower !== req.user.id
      );
      await user.save();
      res.status(200).json("User has been unfollowed");
    } else {
      res.status(400).send("You are not following this user");
    }
  } catch (e) {
    return res.status(500).send(e);
  }
});

router.patch("/users/:id", auth, async (req, res) => {
  const updates = Object.keys(req.body);
  const allowedUpdates = [
    "name",
    "email",
    "password",
    "website",
    "bio",
    "location",
  ];

  const isValidOperation = updates.every((update) =>
    allowedUpdates.includes(update)
  );

  if (!isValidOperation) {
    return res.status(400).send({ error: "Invalid request" });
  }

  try {
    const user = await User.findById(req.user.id);
    updates.forEach((update) => (user[update] = req.body[update]));
    await user.save();
    return res.send(user);
  } catch (e) {
    return res.status(500).send({ error: e });
  }
});
module.exports = router;

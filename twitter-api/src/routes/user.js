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
  console.log(req.body);
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
    res.status(500).send(e);
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

module.exports = router;

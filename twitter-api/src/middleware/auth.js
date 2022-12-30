const jwt = require("jsonwebtoken");
const User = require("./../models/user");

const auth = async (req, res, next) => {
  const rawToken = req.header("Authorization");
  if (!rawToken) {
    return res.status(400).send({ error: "Authentication token needed" });
  }

  try {
    const decoded = jwt.verify(
      rawToken.replace("Bearer ", ""),
      process.env.SECRET_KEY
    );

    const user = await User.findOne({ _id: decoded._id });

    if (!user) {
      return res.status(404).send("User does not exist");
    }

    req.user = user;
    next();
  } catch (e) {
    console.log(e);
    return res.status(400).send({ error: "Invalid token" });
  }
};

module.exports = auth;

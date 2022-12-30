const express = require("express");
require("./db/mongoose");
const dotenv = require("dotenv");
dotenv.config();

const userRouter = require("./routes/user");

const app = express();

app.use(express.json());

const PORT = process.env.PORT || 5001;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

app.use(userRouter);

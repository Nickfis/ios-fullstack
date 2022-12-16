const mongoose = require("mongoose");

mongoose.connect("mongodb://localhost:27017/notes");

mongoose.set("strictQuery", false);

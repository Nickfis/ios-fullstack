const express = require("express");

const app = express();
const PORT = 5001;

app.get("/notes", (req, res) => {});

app.listen(PORT, () => {
  console.log(`API is running on port ${PORT}`);
});

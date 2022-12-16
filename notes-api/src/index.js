require("./db/mongoose");
const express = require("express");
const { populate } = require("./models/note");
const Note = require("./models/note");

const PORT = 5001;

const app = express();
app.use(express.json());

app.get("/notes", async (req, res) => {
  const notes = await Note.find();

  return res.status(200).json(notes);
});

app.post("/notes", async (req, res) => {
  const note = new Note(req.body);

  await note.save();
  res.status(200).send(note);
});

app.put("/notes/:id", async (req, res) => {
  try {
    const note = await Note.findById(req.params.id);
    note.note = req.body.note;
    await note.save();
    res.status(200).json(note);
  } catch (e) {
    console.log(e);
    res.status(500).send(e);
  }
});

app.delete("/notes/:id", async (req, res) => {
  try {
    const note = await Note.findByIdAndDelete(req.params.id);
    res.send("Note has been deleted");
  } catch (err) {
    res.status(500).send(err);
  }
});

app.listen(PORT, () => {
  console.log(`API is running on port ${PORT}`);
});


mongoose = require "mongoose"
Entry = require "./models/entry"
mongoose.connect "mongodb://localhost/otmar"

entries = require "./all-entries.json"


for entryObj in entries
  entry = new Entry entryObj
  entry.save (err) ->
    return console.error err if err?
    console.log "."



Entry = require "../models/entry"

exports.index = (req, res) ->
  Entry.find { }, (err, docs) ->
    res.render "index", { entries: docs }





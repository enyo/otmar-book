
fs = require "fs"

text = fs.readFileSync "#{__dirname}/source - proper encoding.txt", "utf8"

entries = [ ]


keys = { }

currentEntry = { }
entryFilled = no

newEntry = ->
  return unless entryFilled

  entries.push currentEntry
  currentEntry = { }
  entryFilled = no

setEntryValue = (key, value) ->
  keys[key] = yes
  currentEntry[key] = value
  entryFilled = yes


for line in text.split "\n"
  if line.trim() == ""
    newEntry() 
  else
    regex = /^([^\:]+)\:[ ]?(.*)$/i
    throw new Error "Invalid line:\n#{line}" unless regex.test line
    key = line.replace regex, "$1"
    value = line.replace regex, "$2"

    setEntryValue key, value


console.log "Total entries: #{entries.length}"
console.log "Keys: "
for key of keys
  console.log " - #{key}"



mapping = {
  "Archiv Nr": "archiveNumber"
  "Altes Medium": "oldMedium"
  "Titel": "title"
  "Termin": "date"
  "Veröffentlicht": "published"
  "Archivinhalt": "archiveContent"
  "ArchivID": "deprecatedArchiveId"
  "Kommentar": "comment"
  "Kommentar2": "comment2"
  "Seitenangabe": "pageReference"
  "Arbeitsbuch (alt)": "workbook"
  "Arbeitsheft (alt)": "workbooklet"
  "Obsessionen": "obsessions"
  "Medium": "medium"
}



mappedEntries = [ ]
for entryData in entries
  entryObj = { }
  for key, value of entryData
    entryObj[mapping[key]] = value

  mappedEntries.push entryObj



fs.writeFileSync "all-entries.json", JSON.stringify mappedEntries, null, "  "

return


mongoose = require "mongoose"
Entry = require "../../models/entry"
mongoose.connect "mongodb://localhost/otmar"



for entryData in entries
  entryObj = { }
  for key, value of entryData
    entryObj[mapping[key]] = value

  entry = new Entry entryObj
  entry.save (err) ->
    return console.error err if err?
    console.log "."

#   string.push ""
#   string.push ""

# fs.writeFileSync "#{__dirname}/test.txt", string.join("\n")
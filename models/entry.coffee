
mongoose = require "mongoose"
ObjectId = mongoose.Schema.ObjectId


EntrySchema = new mongoose.Schema

  finished: Boolean

  # - Archiv Nr
  archiveNumber: type: String, index: yes

  # - Altes Medium
  oldMedium: String

  # - Medium
  medium: String


  # - Titel
  title: String

  # - Termin
  date: String

  # - Veröffentlicht
  published: String

  # - Archivinhalt
  archiveContent: String

  # - ArchivID
  deprecatedArchiveId: String

  # - Kommentar
  comment: String

  # - Kommentar2
  comment2: String

  # - Seitenangabe
  pageReference: String

  # - Arbeitsbuch (alt)
  workbook: String

  # - Arbeitsheft (alt)
  workbooklet: String

  # - Obsessionen
  obsessions: String


module.exports = mongoose.model "Entry", EntrySchema
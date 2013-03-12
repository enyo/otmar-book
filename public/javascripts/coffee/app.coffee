
o = jQuery

window.App = App = Ember.Application.create
  rootElement: "#main"


###
Store
###
App.Adapter = DS.RESTAdapter.extend
  # url: "/"


  buildURL: (args...) ->
    url = @_super args...
    console.log url
    url.replace "_", "-"

  ajax: (url, type, hash) ->
    hash.url = url;
    hash.type = type;
    hash.dataType = 'json';
    
    hash.context = this;

    if hash.data && type != 'GET'
      hash.contentType = 'application/json; charset=utf-8' 
      hash.data = JSON.stringify(hash.data);

    jQuery.ajax(hash)

  serializer: DS.JSONSerializer.extend
    primaryKey: -> "_id"


App.Adapter.configure "plurals",
  entry: "entries"

App.store = DS.Store.create
  revision: 12
  adapter: App.Adapter.create()



###
Models
###

attr = DS.attr

App.Entry = DS.Model.extend

  editing: no
  test: "bla"


  finished: attr "boolean"

  # - Archiv Nr
  archiveNumber: attr "string"

  # - Altes Medium
  oldMedium: attr "string"

  # - Medium
  medium: attr "string"


  # - Titel
  title: attr "string"

  # - Termin
  date: attr "string"

  # - Veröffentlicht
  published: attr "string"

  # - Archivinhalt
  archiveContent: attr "string"

  # - ArchivID
  deprecatedArchiveId: attr "string"

  # - Kommentar
  comment: attr "string"

  # - Kommentar2
  comment2: attr "string"

  # - Seitenangabe
  pageReference: attr "string"

  # - Arbeitsbuch (alt)
  workbook: attr "string"

  # - Arbeitsheft (alt)
  workbooklet: attr "string"

  # - Obsessionen
  obsessions: attr "string"




###
Router
###
App.Router.map (match) ->

  @resource "entries", ->
    @route "entry", path: "/:entry_id"


App.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo "entries"


App.EntriesIndexRoute = Ember.Route.extend
  model: ->
    window.test = this
    App.Entry.find()
    App.Entry.all()
  events:
    editEntry: (entry) ->
      entry.set "editing", yes
    saveEntry: (entry) ->
      entry.set "editing", false
      alert("Änderungen werden noch nicht wirklich gespeichert!")



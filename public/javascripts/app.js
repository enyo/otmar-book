// Generated by CoffeeScript 1.6.1
(function() {
  var App, attr, o,
    __slice = [].slice;

  o = jQuery;

  window.App = App = Ember.Application.create({
    rootElement: "#main"
  });

  /*
  Store
  */


  App.Adapter = DS.RESTAdapter.extend({
    buildURL: function() {
      var args, url;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      url = this._super.apply(this, args);
      console.log(url);
      return url.replace("_", "-");
    },
    ajax: function(url, type, hash) {
      hash.url = url;
      hash.type = type;
      hash.dataType = 'json';
      hash.context = this;
      if (hash.data && type !== 'GET') {
        hash.contentType = 'application/json; charset=utf-8';
        hash.data = JSON.stringify(hash.data);
      }
      return jQuery.ajax(hash);
    },
    serializer: DS.JSONSerializer.extend({
      primaryKey: function() {
        return "_id";
      }
    })
  });

  App.Adapter.configure("plurals", {
    entry: "entries"
  });

  App.store = DS.Store.create({
    revision: 12,
    adapter: App.Adapter.create()
  });

  /*
  Models
  */


  attr = DS.attr;

  App.Entry = DS.Model.extend({
    finished: attr("boolean"),
    archiveNumber: attr("string"),
    oldMedium: attr("string"),
    medium: attr("string"),
    title: attr("string"),
    date: attr("string"),
    published: attr("string"),
    archiveContent: attr("string"),
    deprecatedArchiveId: attr("string"),
    comment: attr("string"),
    comment2: attr("string"),
    pageReference: attr("string"),
    workbook: attr("string"),
    workbooklet: attr("string"),
    obsessions: attr("string")
  });

  /*
  Router
  */


  App.Router.map(function(match) {
    return this.resource("entries", function() {
      return this.route("entry", {
        path: "/:entry_id"
      });
    });
  });

  App.IndexRoute = Ember.Route.extend({
    redirect: function() {
      return this.transitionTo("entries");
    }
  });

  App.EntriesIndexRoute = Ember.Route.extend({
    model: function() {
      window.test = this;
      App.Entry.find();
      return App.Entry.all();
    }
  });

}).call(this);
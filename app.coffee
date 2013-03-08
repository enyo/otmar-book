
###
Module dependencies.
###
express = require "express"
stylus = require "stylus"
nib = require "nib"
routes = require "./routes"
http = require "http"
path = require "path"
mongoose = require "mongoose"
app = express()


mongoose.connect "mongodb://localhost/otmar"


app.configure ->
  app.set "port", process.env.PORT or 3003
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router


  compile = (str, path) ->
    stylus(str)
      .set('filename', path)
      .set('compress', true)
      .use(nib())

  app.use stylus.middleware
    src: __dirname + "/public"
    compile: compile

  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index

mongoRest = new (require("mongo-rest")) app,
  enableXhr: true

mongoRest.addResource require("./models/entry"), sort: "-archiveNumber"

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")


###
Module dependencies.
###
express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
app = express()
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/src/client/jade"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use require("stylus").middleware(__dirname + "/www/css")
  app.use express.static(path.join(__dirname, "www"))

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

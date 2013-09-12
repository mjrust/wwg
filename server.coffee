require('coffee-script')

express  = require "express"
cons     = require "consolidate"
partials = require "express-partials"
port     = 3700

# initialize express
app = express()

app.configure () ->
  app.use express.logger('dev')  # 'default', 'short', 'tiny', 'dev'
  app.engine 'eco', cons.eco
  app.set 'view engine', 'eco'
  app.use partials()
  app.use require('connect-assets')()
  app.use express.static(__dirname + '/public')
  app.set 'views', __dirname + '/views'
  app.use express.bodyParser()

# Home
app.get '/', (req, res) ->
  res.render 'index', title: 'When and Where Golf', name: 'Matt Rust', layout: 'application', nav: 'nav'

# Course routes
course = require("./routes/course.coffee")
app.get '/courses', course.list
app.get '/course/:id', course.show
app.post '/course', course.create
app.put '/course/:id', course.update
app.del '/course/:id', course.delete
app.get '/admin', course.admin

io = require('socket.io').listen(app.listen(port))

io.sockets.on 'connection', (socket) ->
  socket.emit 'message', message: 'welcome to the chat'
  socket.on 'send', (data) ->
    io.sockets.emit 'message', data

console.log "Listening on port " + port

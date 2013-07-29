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


CourseModel = require("./models.coffee").CourseModel

app.get '/', (req, res) ->
  res.render 'index', title: 'When and Where Golf', name: 'Matt Rust', layout: 'application', nav: 'nav'

app.get '/courses', (req, res) ->
  CourseModel.find (err, courses) ->
    if !err
      res.send courses
    else
      console.log err

app.get '/course/:id', (req, res) ->
  CourseModel.findById req.params.id, (err, course) ->
    if !err
      res.send course
    else
      console.log err

app.post '/course', (req, res) ->
  console.log "POST: "
  console.log req.body
  course = new CourseModel
    name: req.body.name
    city: req.body.city
  course.save (err) ->
    if !err
      console.log "created"
    else
      console.log err
  res.send course

app.put '/course/:id', (req, res) ->
  CourseModel.findById req.params.id, (err, course) ->
    course.name = req.body.name
    course.city = req.body.city
    course.save (err) ->
      if !err
        console.log "updated"
        res.send "Course with id: #{req.params.id} was updated\n\n"
      else
        console.log "error"
        console.log err
      res.send course

app.del '/course/:id', (req, res) ->
  CourseModel.findById req.params.id, (err, course) ->
    course.remove (err) ->
      if !err
        console.log "removed"
        res.send "Course with id: #{req.params.id} was deleted\n\n"
      else
        console.log err

app.get '/admin', (req, res) ->
  CourseModel.find (err, courses) ->
    if !err
      res.render 'admin', title: 'When and Where Golf', name: 'Matt Rust', layout: 'application', nav: 'nav', courses: courses
    else
      console.log err

io = require('socket.io').listen(app.listen(port))

io.sockets.on 'connection', (socket) ->
  socket.emit 'message', message: 'welcome to the chat'
  socket.on 'send', (data) ->
    io.sockets.emit 'message', data

console.log "Listening on port " + port

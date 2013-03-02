require('coffee-script')

express  = require "express"
mongoose = require "mongoose"
cons     = require "consolidate"
partials = require "express-partials"

# Database
db = mongoose.connect('mongodb://localhost/wwg')
app = express()

app.configure () ->
  app.use express.logger('dev')  # 'default', 'short', 'tiny', 'dev'
  app.engine 'eco', cons.eco
  app.set 'view engine', 'eco'
  app.use partials()
  app.use express.static(__dirname + '/public')
  app.set 'views', __dirname + '/views'
  app.use express.bodyParser()
  
Schema = mongoose.Schema

Course = new Schema
  name: { type: String, required: true }
  city: { type: String, required: true }
  modified: { type: Date, default: Date.now }

CourseModel = mongoose.model('Course', Course)

app.get '/', (req, res) ->
  res.render 'index', title: 'When and Where Golf', name: 'Matt Rust', layout: 'application'
  
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



app.listen 3001
console.log 'Listening on port 3001'

require('coffee-script')

express = require('express')
mongoose = require('mongoose')

# Database
db = mongoose.connect('mongodb://localhost/wwg')
app = express()

app.configure () ->
  app.use express.logger('dev')  # 'default', 'short', 'tiny', 'dev'
  app.use express.bodyParser()

Schema = mongoose.Schema

Course = new Schema
  name: { type: String, required: true }
  city: { type: String, required: true }
  modified: { type: Date, default: Date.now }

CourseModel = mongoose.model('Course', Course)

app.get '/', (req, res) ->
  res.send "When and Where Golf"
  
app.get '/courses', (req, res) ->
  CourseModel.find (err, courses) ->
    if !err
      res.send courses + "\n\n"
    else
      console.log err
      
app.get '/course/:id', (req, res) ->
  CourseModel.findById req.params.id, (err, course) ->
    if !err
      res.send course + "\n\n"
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
  res.send course + "\n\n"
  
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
      res.send course + "\n\n"
    
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

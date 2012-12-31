require('coffee-script')


express = require('express')
# course = require('./routes/courses')
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

app.get '/courses', (req, res) ->
  CourseModel.find (err, courses) ->
    if !err
      res.send courses
    else
      console.log err
app.get '/courses/:id', (req, res) ->
  CourseModel.findById req.params.id, (err, course) ->
    if !err
      res.send course
    else
      console.log err
app.post '/courses', (req, res) ->
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
# app.put('/courses/:id', course.updateCourse);
# app.del('/courses/:id', course.deleteCourse);


app.listen 3000
console.log 'Listening on port 3000'

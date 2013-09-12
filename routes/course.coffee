CourseModel = require("../models.coffee").CourseModel

exports.list = (req, res) ->
  CourseModel.find (err, courses) ->
    if !err
      res.send courses
    else
      console.log err

exports.show = (req, res) ->
  CourseModel.findById req.params.id, (err, course) ->
    if !err
      res.send course
    else
      console.log err

exports.create = (req, res) ->
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

exports.update = (req, res) ->
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

exports.delete = (req, res) ->
  CourseModel.findById req.params.id, (err, course) ->
    course.remove (err) ->
      if !err
        console.log "removed"
        res.send "Course with id: #{req.params.id} was deleted\n\n"
      else
        console.log err

exports.admin = (req, res) ->
  CourseModel.find (err, courses) ->
    if !err
      res.render 'admin', title: 'When and Where Golf', name: 'Matt Rust', layout: 'application', nav: 'nav', courses: courses
    else
      console.log err
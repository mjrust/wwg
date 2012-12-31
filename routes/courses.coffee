exports.findAll = (req, res) ->
  CourseModel.find (err, courses) ->
    if !err
      res.send courses
    else
      console.log err

exports.findById = (req, res) ->
  res.send id:req.params.id, course_name: "The Fort", city: "Indianapolis"

# exports.addCourse = (req, res) ->
#   course = req.body
#   console.log "Adding course: " + JSON.stringify(course)
#   db.collection "courses", (err, collection) ->
#     collection.insert course,
#       safe: true
#     , (err, result) ->
#       if err
#         res.send error: "An error has occurred"
#       else
#         console.log "Success: " + JSON.stringify(result[0])
#         res.send result[0]

# exports.updateCourse = (req, res) ->
#   id = req.params.id
#   course = req.body
#   console.log "Updating Course: " + id
#   console.log JSON.stringify(Course)
#   db.collection "courses", (err, collection) ->
#     collection.update
#       _id: new BSON.ObjectID(id)
#     , course,
#       safe: true
#     , (err, result) ->
#       if err
#         console.log "Error updating Course: " + err
#         res.send error: "An error has occurred"
#       else
#         console.log "" + result + " document(s) updated"
#         res.send course

# exports.deleteCourse = (req, res) ->
#   id = req.params.id
#   console.log "Deleting course: " + id
#   db.collection "courses", (err, collection) ->
#     collection.remove
#       _id: new BSON.ObjectID(id)
#     ,
#       safe: true
#     , (err, result) ->
#       if err
#         res.send error: "An error has occurred - " + err
#       else
#         console.log "" + result + " document(s) deleted"
#         res.send req.body

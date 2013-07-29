mongoose = require "mongoose"
db = mongoose.connect('mongodb://localhost/wwg')
Schema = mongoose.Schema

Course = new Schema
  name: type: String, required: true
  city: type: String, required: true
  state: type: String, required: true
  metro: String
  region: String
  country: String
  price:
    rack: Number
    twilight: Number
    fall: Number
    winter: Number
    spring: Number
    summer: Number
    spec_1: Number
    spec_2: Number
    spec_3: Number
  modified: type: Date, default: Date.now

exports.CourseModel  = mongoose.model('Course', Course)
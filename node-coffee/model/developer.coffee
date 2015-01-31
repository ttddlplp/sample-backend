mongoose = require "mongoose"

Developer = new mongoose.Schema
  name : {type : String, trim : true}
  desc : String
  gender : String

mongoose.model "Developer", Developer
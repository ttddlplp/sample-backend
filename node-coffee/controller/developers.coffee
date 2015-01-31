mongoose = require 'mongoose'

exports.retrieve = (req, res) ->
  Resource = mongoose.model('Developer')

  if req.params.id?
    Resource.findById req.params.id, (err, resource) ->
      return res.send(500, { error: err }) if err?
      return res.send(resource) if resource?
      res.send(404)
  else
    Resource.find {}, (err, coll) ->
      res.send(coll)

exports.create = (req, res) ->
  Resource = mongoose.model('Developer')
  fields = req.body
  return res.status(400).send("Invalid JSON.") if !fields?

  r = new Resource(fields)
  r.save (err, resource) ->
    return res.send(500, { error: err }) if err?
    res.send(resource)

exports.update = (req, res) ->
  Resource = mongoose.model('Developer')
  fields = req.body

  Resource.findByIdAndUpdate req.params.id, { $set: fields }, (err, resource) ->
    return res.send(500, { error: err }) if err?
    return res.send(resource) if resource?
    res.sendStatus(404)

exports.delete = (req, res) ->
  Resource = mongoose.model('Developer')

  Resource.findByIdAndRemove req.params.id, (err, resource) ->
    return res.send(500, { error: err }) if err?
    return res.send(200) if resource?
    res.send(404)

exports.deleteAll = (req, res) ->
  Resource = mongoose.model('Developer')

  Resource.find {}, (err, coll) ->
    return res.send(500, {error: err}) if err?
    coll.forEach (developer) ->
      Resource.findByIdAndRemove developer.id, (err, resource) ->
      return res.send(500, {error: err}) if err?
    res.sendStatus(200)

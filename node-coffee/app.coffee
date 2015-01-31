express  = require 'express'
mongoose = require 'mongoose'
bodyParser = require 'body-parser'
developers = require './controller/developers'
require 'method-override'

app = express()

app.set 'port', process.env.PORT or 4000
app.set 'storage-uri',
  process.env.MONGOHQ_URL or
  process.env.MONGOLAB_URI or
  'mongodb://localhost/developers'

mongoose.connect app.get('storage-uri'), { db: { safe: true }}, (err) ->
  if err then console.log "Mongoose - connection error: " + err
  else console.log "Mongoose - connection OK"

require './model/developer'

app.get '/', (req, res) ->
  res.send 'Hello, every SB!'

app.post    '/developers',     developers.create
app.get     '/developers',     developers.retrieve
app.get     '/developers/:id', developers.retrieve
app.put     '/developers/:id', developers.update
app.delete  '/developers/:id', developers.delete


app.listen app.get('port'), ->
  console.log "Listening on port #{app.get('port')}"



DiffSync = require('diffsync')
express  = require('express')

app  = express()
http = require('http').Server(app)
io   = require('socket.io')(http)

dataAdapter    = new DiffSync.InMemoryDataAdapter()
diffSyncServer = new DiffSync.Server(dataAdapter, io)

app.use express.static(__dirname + '/../public')

http.listen 4000, -> console.log 'visit http://127.0.0.1:4000'

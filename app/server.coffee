DiffSync = require('diffsync')
express  = require('express')

app  = express()
http = require('http').Server(app)
io   = require('socket.io')(http)

dataAdapter    = new DiffSync.InMemoryDataAdapter()
diffSyncServer = new DiffSync.Server(dataAdapter, io)

diffSyncServer.on 'connected', (connection, data, room) ->
  connection.emit 'log', { msg: 'connected', data, room }

diffSyncServer.on 'doc_not_found', (connection, editMessage) ->
  connection.emit 'log', { msg: 'doc_not_found', editMessage }

diffSyncServer.on 'patch', (clientDoc, connection, edit, editMessage) ->
  connection.emit 'log', { msg: 'patch', edit, editMessage }

diffSyncServer.on 'patch_rejected', (clientDoc, connection, edit, editMessage) ->
  connection.emit 'log', { msg: 'patch_rejected', edit, editMessage }

app.use express.static(__dirname + '/../public')

http.listen 4000, -> console.log 'visit http://127.0.0.1:4000'

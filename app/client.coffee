DiffSync = require 'diffsync'
socket   = require('socket.io-client')()
client   = new DiffSync.Client(socket, 'test')
data     = undefined

document.addEventListener 'DOMContentLoaded', (event) ->
  textarea = document.getElementsByTagName('TEXTAREA')[0]

  update = ->
    data = client.getData()
    textarea.value = JSON.stringify(data, null, 2)

  textarea.addEventListener 'input', (event) ->
    new_data = undefined

    try
      new_data = JSON.parse(textarea.value)
      for key of new_data
        data[key] = new_data[key]
      client.sync()
    catch e
      console.log 'invalid json'
  
  client.on 'connected', ->
    console.log 'client connected'
    update()

  socket.on 'log', (data) ->
    console.log data
  
  client.on 'synced', ->
    console.log 'client synced'
    update()
  
  client.initialize()

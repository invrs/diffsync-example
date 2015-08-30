DiffSync = require 'diffsync'
socket   = require 'socket.io-client'
client   = new DiffSync.Client(socket(), 'test')
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
      console.log e
  
  client.on 'connected', ->
    console.log 'connected'
    update()
  
  client.on 'synced', ->
    console.log 'synced'
    update()
  
  client.initialize()

fs    = require("fs")
tasks = fs.readdirSync("./gulp")

tasks.forEach (task) ->
  if task != "index.coffee" && task.indexOf ".coffee" > -1
    require "./#{task}"

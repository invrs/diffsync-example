path = require "path"
gulp = require "gulp"
run  = require "gulp-run"

gulp.task "scripts", ->
  dest = "./public/client.js"
  bin  = path.resolve "#{__dirname}/../../node_modules/.bin"
  cmd  = "#{bin}/browserify --extension=.coffee app/client.coffee > #{dest}"
  run(cmd).exec()

require "../src/tilo"
require "./constants"

Log.setup(:debug)

GC.disable

# You can connect to the JavaScript engine for debugging and as such.
puts "JavaScript engine running at: #{Tilo::JavaScript::Engine.instance.path}"

builder = Tilo::Builder.new(content_directory: Constants::CONTENT_DIRECTORY)
builder.build

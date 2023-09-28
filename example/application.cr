require "../src/tilo"
require "./constants"

# Log.setup(:debug)

# GC.disable

# # You can connect to the JavaScript engine for debugging and as such.
# puts "JavaScript engine running at: #{Tilo::JavaScript::Engine.instance.path}"

# builder = Tilo::Builder.new(content_directory: Constants::CONTENT_DIRECTORY)
# builder.build

GC.disable

html = <<-HTML
  <Application applicationId="com.tilo.application">
    <Window title="Untitled Window">
      <Label>Hello, World!</Label>
    </Window>
  </Application>
HTML

builder = Tilo::Builder.new
# Make sure you point the path the correct way.
builder.build_from_string(html)
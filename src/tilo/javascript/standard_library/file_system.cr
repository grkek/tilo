module Tilo
  module JavaScript
    module StandardLibrary
      class FileSystem
        def initialize(sandbox : Duktape::Sandbox)
          sandbox.push_global_proc("FileSystem__ReadFile", 1) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              path = env.require_string 0

              File.open path do |fd|
                env.push_string fd.gets_to_end
              end

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("FileSystem__FileExists", 1) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              path = env.require_string 0
              env.push_boolean File.exists? path
              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("FileSystem__WriteFile", 2) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              path = env.require_string 0
              content = env.require_string 1

              File.write(path, content)

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("FileSystem__DirectoryChildren", 1) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              path = env.require_string 0

              env.call_failure if File.file? path
              children = Dir.children path

              array_index = env.push_array

              children.each do |child|
                child_index = children.index(child) || raise "Unable to locate the index of the child"
                absolute_path = File.expand_path path + child

                object_index = env.push_object

                env.push_boolean File.directory? absolute_path
                env.put_prop_string object_index, "isDirectory"

                env.push_boolean File.file? absolute_path
                env.put_prop_string object_index, "isFile"

                env.push_string absolute_path
                env.put_prop_string object_index, "absolutePath"

                env.put_prop_index array_index, child_index.to_u32
              end

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("FileSystem__ExpandPath", 1) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              path = env.require_string 0

              env.call_failure if File.file? path
              env.push_string File.expand_path path

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end
        end
      end
    end
  end
end

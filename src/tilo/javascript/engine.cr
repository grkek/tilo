module Tilo
  module JavaScript
    class Engine
      @@instance = new

      mutex : Mutex
      server : UNIXServer

      getter sandbox : Duktape::Sandbox
      getter path : String = "/tmp/#{UUID.random}.sock"

      property paths : Helpers::Synchronized(Array(String)) = Helpers::Synchronized(Array(String)).new

      def self.instance
        @@instance
      end

      def initialize
        @sandbox = Duktape::Sandbox.new

        @mutex = Mutex.new(:reentrant)
        @server = UNIXServer.new(path)

        modules = [
          StandardLibrary::FileSystem.new(sandbox),
          StandardLibrary::Cryptography.new(sandbox),
          StandardLibrary::UserInterface.new(sandbox),
          StandardLibrary::Http.new(sandbox),
        ]

        modules.each do |library_module|
          library_module
        end

        sandbox.eval!("const exports = {};")

        require_resolver_procedure = ->(import_path : String) {
          clean_path = import_path
            .gsub("../", String.new)
            .gsub("./", String.new)
            .+(".js")

          paths.each do |path|
            if path.includes?(clean_path)
              return path
            end
          end
        }

        sandbox.push_heap_stash
        sandbox.push_pointer(::Box.box(require_resolver_procedure))
        sandbox.put_prop_string(-2, "requireResolverClosure")

        sandbox.push_global_proc("resolveRequire", 1) do |ptr|
          env = Duktape::Sandbox.new ptr

          env.push_heap_stash
          env.get_prop_string(-1, "requireResolverClosure")
          require_closure = ::Box(Proc(String, String)).unbox(env.get_pointer(-1))

          import_path = env.require_string 0

          env.push_string require_closure.call(import_path)
          env.call_success
        end

        sandbox.eval! <<-JS
          const require = function(path) {
            const expandedPath = resolveRequire(path);

            if(FileSystem__FileExists(expandedPath)){
              var fileContent = FileSystem__ReadFile(expandedPath);

              eval(fileContent);

              var localExports = exports;

              exports = {};

              return localExports;
            } else {
              throw "File doesn't exist, " + expandedPath
            }
          }
        JS

        # Handle incomming connections to the socket.
        spawn do
          loop do
            if client = @server.accept?
              spawn handle_client(client)
            end
          end
        end
      end

      private def handle_client(client : UNIXSocket)
        loop do
          request = Message::Request.from_json(client.gets || raise Exceptions::RuntimeException.new("Unable to collect socket data"))

          @mutex.synchronize do
            if request.processing == Message::Processing::EVENT
              Registry.instance.refresh_state(request.id)
            end

            if source_code = request.source_code
              begin
                eval! source_code
              rescue exception
                Log.error(exception: exception) { exception.message }

                Log.debug { source_code }
                Log.info { [request.id, request.directory, request.file, request.line].join(", ") }
              end
            end
          end
        end
      end

      private def eval!(source_code : String)
        @sandbox.eval_mutex! source_code
      end
    end
  end
end

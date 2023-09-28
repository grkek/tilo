module Tilo
  module JavaScript
    module StandardLibrary
      class Http
        def initialize(sandbox : Duktape::Sandbox)
          sandbox.push_global_proc("Http__Get", 1) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              url = env.require_string 0

              response = HTTP::Client.get url

              object_index = env.push_object

              env.push_int response.status_code
              env.put_prop_string object_index, "statusCode"

              env.push_string response.body
              env.put_prop_string object_index, "body"

              header_object_index = env.push_object

              response.headers.keys.each do |key|
                env.push_string response.headers.[key]
                env.put_prop_string header_object_index, key.name.downcase
              end

              env.put_prop_string object_index, "headers"

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("Http__Post", 2) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              url = env.require_string 0
              body = env.require_string 1

              HTTP::Client.post(url, headers: HTTP::Headers{"Content-Type" => "application/json"}, body: body) do |response|
                object_index = env.push_object

                env.push_int response.status_code
                env.put_prop_string object_index, "statusCode"

                env.push_string response.body
                env.put_prop_string object_index, "body"

                header_object_index = env.push_object

                response.headers.keys.each do |key|
                  env.push_string response.headers.[key]
                  env.put_prop_string header_object_index, key.name.downcase
                end

                env.put_prop_string object_index, "headers"
              end

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

require "digest/md5"

module Tilo
  module JavaScript
    module StandardLibrary
      class Cryptography
        def initialize(sandbox : Duktape::Sandbox)
          sandbox.push_global_proc("Cryptography__UUID4", 0) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              env.push_string UUID.random.to_s
              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("Cryptography__MD5", 1) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              digest = Digest::MD5.new

              input = env.require_string 0
              digest.update input
              env.push_string digest.hexfinal

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

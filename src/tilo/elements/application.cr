require "./node"
require "./generic"

module Tilo
  module Elements
    class Application < Generic
      getter kind : String = "Application"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end
    end
  end
end

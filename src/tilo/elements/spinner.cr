require "./node"
require "./generic"

module Tilo
  module Elements
    class Spinner < Generic
      getter kind : String = "Spinner"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end
    end
  end
end

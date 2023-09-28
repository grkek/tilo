require "./node"
require "./generic"

module Tilo
  module Elements
    class Import < Generic
      getter kind : String = "Import"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end
    end
  end
end

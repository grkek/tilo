module Tilo
  module Attributes
    class Container
      include JSON::Serializable

      @[JSON::Field(key: "containerLabel")]
      property container_label : String = "Untitled"

      @[JSON::Field(key: "containerExpand")]
      property? expand : Bool = false

      @[JSON::Field(key: "containerFill")]
      property? fill : Bool = false

      @[JSON::Field(key: "containerPadding")]
      property padding : Int32 = 0
    end
  end
end

require "./node"
require "./generic"

module Tilo
  module Elements
    module Attributes
      class Image < Tilo::Attributes::Base
      end
    end

    class Image < Generic
      getter kind : String = "Image"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end

      def build_widget(parent : Gtk::Widget) : Gtk::Widget
        image = Attributes::Image.from_json(attributes.to_json)
        container_attributes = Tilo::Attributes::Container.from_json(attributes.to_json)

        widget = Gtk::Picture.new_for_file(file: Gio::File.new_for_uri("https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Crystal_language_logo.svg/1200px-Crystal_language_logo.svg.png"))

        widget.name = image.id
        widget.halign = image.horizontal_alignment
        widget.valign = image.vertical_alignment

        register_events(widget)
        containerize(parent, widget, container_attributes)
        add_class_to_css(widget, image.class_name)

        register_component(widget, image.class_name, @kind)
        widget
      end
    end
  end
end

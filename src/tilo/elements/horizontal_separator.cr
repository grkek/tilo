require "./node"
require "./generic"

module Tilo
  module Elements
    class HorizontalSeparator < Generic
      getter kind : String = "HorizontalSeparator"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end

      def build_widget(parent : Gtk::Widget) : Gtk::Widget
        separator = Tilo::Attributes::Separator.from_json(attributes.to_json)
        container_attributes = Tilo::Attributes::Container.from_json(attributes.to_json)

        widget = Gtk::Separator.new(name: separator.id, orientation: Gtk::Orientation::Horizontal, halign: separator.horizontal_alignment, valign: separator.vertical_alignment)

        containerize(parent, widget, container_attributes)
        add_class_to_css(widget, separator.class_name)

        widget
      end
    end
  end
end

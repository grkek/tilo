require "digest/md5"

module Tilo
  module JavaScript
    module StandardLibrary
      class UserInterface
        def initialize(sandbox : Duktape::Sandbox)
          sandbox.push_global_proc("UserInterface__GetWidget", 1) do |ptr|
            env = Duktape::Sandbox.new ptr
            begin
              id = env.require_string 0

              if component = Registry.instance.registered_components[id]?
                env.push_pointer ::Box.box component.widget
              else
                next env.call_failure
              end

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__GetWidgetParent", 1) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0

              if component = Registry.instance.registered_components[id]?
                if parent = component.widget.parent
                  env.push_string parent.name
                else
                  next env.call_failure
                end
              else
                next env.call_failure
              end

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__GetMainWindow", 0) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              if component = Registry.instance.registered_components.values.first
                env.push_pointer ::Box.box component.widget
              else
                next env.call_failure
              end

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__Label", 10) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0
              class_name = env.require_string 1
              parent_widget = ::Box(Gtk::Widget).unbox(env.require_pointer(2))

              container_label = env.require_string 3
              container_expand = env.require_boolean 4
              container_fill = env.require_boolean 5
              container_padding = env.require_number 6

              horizontal_alignment = env.require_number 7
              vertical_alignment = env.require_number 8
              orientation = env.require_number 9

              attributes = {
                "id"                  => JSON::Any.new(id),
                "className"           => JSON::Any.new(class_name),
                "containerLabel"      => JSON::Any.new(container_label),
                "containerExpand"     => JSON::Any.new(container_expand),
                "containerFill"       => JSON::Any.new(container_fill),
                "containerPadding"    => JSON::Any.new(container_padding.to_i32),
                "horizontalAlignment" => JSON::Any.new(Gtk::Align.new(horizontal_alignment.to_u32).to_s),
                "verticalAlignment"   => JSON::Any.new(Gtk::Align.new(vertical_alignment.to_u32).to_s),
                "orientation"         => JSON::Any.new(Gtk::Orientation.new(orientation.to_u32).to_s),
              } of String => JSON::Any

              label = Elements::Label.new(attributes, [] of Elements::Node)
              widget = label.build_widget(parent_widget)

              env.push_pointer ::Box.box widget
              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__Box", 10) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0
              class_name = env.require_string 1
              parent_widget = ::Box(Gtk::Widget).unbox(env.require_pointer(2))

              container_label = env.require_string 3
              container_expand = env.require_boolean 4
              container_fill = env.require_boolean 5
              container_padding = env.require_number 6

              horizontal_alignment = env.require_number 7
              vertical_alignment = env.require_number 8
              orientation = env.require_number 9

              attributes = {
                "id"                  => JSON::Any.new(id),
                "className"           => JSON::Any.new(class_name),
                "containerLabel"      => JSON::Any.new(container_label),
                "containerExpand"     => JSON::Any.new(container_expand),
                "containerFill"       => JSON::Any.new(container_fill),
                "containerPadding"    => JSON::Any.new(container_padding.to_i32),
                "horizontalAlignment" => JSON::Any.new(Gtk::Align.new(horizontal_alignment.to_u32).to_s),
                "verticalAlignment"   => JSON::Any.new(Gtk::Align.new(vertical_alignment.to_u32).to_s),
                "orientation"         => JSON::Any.new(Gtk::Orientation.new(orientation.to_u32).to_s),
              } of String => JSON::Any

              box = Elements::Box.new(attributes, [] of Elements::Node)
              widget = box.build_widget(parent_widget)

              env.push_pointer ::Box.box widget
              env.call_success

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__Button", 10) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0
              class_name = env.require_string 1
              parent_widget = ::Box(Gtk::Widget).unbox(env.require_pointer(2))

              container_label = env.require_string 3
              container_expand = env.require_boolean 4
              container_fill = env.require_boolean 5
              container_padding = env.require_number 6

              horizontal_alignment = env.require_number 7
              vertical_alignment = env.require_number 8
              orientation = env.require_number 9

              attributes = {
                "id"                  => JSON::Any.new(id),
                "className"           => JSON::Any.new(class_name),
                "containerLabel"      => JSON::Any.new(container_label),
                "containerExpand"     => JSON::Any.new(container_expand),
                "containerFill"       => JSON::Any.new(container_fill),
                "containerPadding"    => JSON::Any.new(container_padding.to_i32),
                "horizontalAlignment" => JSON::Any.new(Gtk::Align.new(horizontal_alignment.to_u32).to_s),
                "verticalAlignment"   => JSON::Any.new(Gtk::Align.new(vertical_alignment.to_u32).to_s),
                "orientation"         => JSON::Any.new(Gtk::Orientation.new(orientation.to_u32).to_s),
              } of String => JSON::Any

              button = Elements::Button.new(attributes, [] of Elements::Node)
              widget = button.build_widget(parent_widget)

              env.push_pointer ::Box.box widget
              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__ListBox", 10) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0
              class_name = env.require_string 1
              parent_widget = ::Box(Gtk::Widget).unbox(env.require_pointer(2))

              container_label = env.require_string 3
              container_expand = env.require_boolean 4
              container_fill = env.require_boolean 5
              container_padding = env.require_number 6

              horizontal_alignment = env.require_number 7
              vertical_alignment = env.require_number 8
              orientation = env.require_number 9

              attributes = {
                "id"                  => JSON::Any.new(id),
                "className"           => JSON::Any.new(class_name),
                "containerLabel"      => JSON::Any.new(container_label),
                "containerExpand"     => JSON::Any.new(container_expand),
                "containerFill"       => JSON::Any.new(container_fill),
                "containerPadding"    => JSON::Any.new(container_padding.to_i32),
                "horizontalAlignment" => JSON::Any.new(Gtk::Align.new(horizontal_alignment.to_u32).to_s),
                "verticalAlignment"   => JSON::Any.new(Gtk::Align.new(vertical_alignment.to_u32).to_s),
                "orientation"         => JSON::Any.new(Gtk::Orientation.new(orientation.to_u32).to_s),
              } of String => JSON::Any

              list_box = Elements::ListBox.new(attributes, [] of Elements::Node)
              widget = list_box.build_widget(parent_widget)

              env.push_pointer ::Box.box widget
              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__ScrolledWindow", 10) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0
              class_name = env.require_string 1
              parent_widget = ::Box(Gtk::Widget).unbox(env.require_pointer(2))

              container_label = env.require_string 3
              container_expand = env.require_boolean 4
              container_fill = env.require_boolean 5
              container_padding = env.require_number 6

              horizontal_alignment = env.require_number 7
              vertical_alignment = env.require_number 8
              orientation = env.require_number 9

              attributes = {
                "id"                  => JSON::Any.new(id),
                "className"           => JSON::Any.new(class_name),
                "containerLabel"      => JSON::Any.new(container_label),
                "containerExpand"     => JSON::Any.new(container_expand),
                "containerFill"       => JSON::Any.new(container_fill),
                "containerPadding"    => JSON::Any.new(container_padding.to_i32),
                "horizontalAlignment" => JSON::Any.new(Gtk::Align.new(horizontal_alignment.to_u32).to_s),
                "verticalAlignment"   => JSON::Any.new(Gtk::Align.new(vertical_alignment.to_u32).to_s),
                "orientation"         => JSON::Any.new(Gtk::Orientation.new(orientation.to_u32).to_s),
              } of String => JSON::Any

              scrolled_window = Elements::ScrolledWindow.new(attributes, [] of Elements::Node)
              widget = scrolled_window.build_widget(parent_widget)

              env.push_pointer ::Box.box widget
              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__Entry", 10) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0
              class_name = env.require_string 1
              parent_widget = ::Box(Gtk::Widget).unbox(env.require_pointer(2))

              container_label = env.require_string 3
              container_expand = env.require_boolean 4
              container_fill = env.require_boolean 5
              container_padding = env.require_number 6

              horizontal_alignment = env.require_number 7
              vertical_alignment = env.require_number 8
              orientation = env.require_number 9

              attributes = {
                "id"                  => JSON::Any.new(id),
                "className"           => JSON::Any.new(class_name),
                "containerLabel"      => JSON::Any.new(container_label),
                "containerExpand"     => JSON::Any.new(container_expand),
                "containerFill"       => JSON::Any.new(container_fill),
                "containerPadding"    => JSON::Any.new(container_padding.to_i32),
                "horizontalAlignment" => JSON::Any.new(Gtk::Align.new(horizontal_alignment.to_u32).to_s),
                "verticalAlignment"   => JSON::Any.new(Gtk::Align.new(vertical_alignment.to_u32).to_s),
                "orientation"         => JSON::Any.new(Gtk::Orientation.new(orientation.to_u32).to_s),
              } of String => JSON::Any

              entry = Elements::Entry.new(attributes, [] of Elements::Node)
              widget = entry.build_widget(parent_widget)

              env.push_pointer ::Box.box widget
              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__Image", 10) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0
              class_name = env.require_string 1
              parent_widget = ::Box(Gtk::Widget).unbox(env.require_pointer(2))

              container_label = env.require_string 3
              container_expand = env.require_boolean 4
              container_fill = env.require_boolean 5
              container_padding = env.require_number 6

              horizontal_alignment = env.require_number 7
              vertical_alignment = env.require_number 8
              orientation = env.require_number 9

              attributes = {
                "id"                  => JSON::Any.new(id),
                "className"           => JSON::Any.new(class_name),
                "containerLabel"      => JSON::Any.new(container_label),
                "containerExpand"     => JSON::Any.new(container_expand),
                "containerFill"       => JSON::Any.new(container_fill),
                "containerPadding"    => JSON::Any.new(container_padding.to_i32),
                "horizontalAlignment" => JSON::Any.new(Gtk::Align.new(horizontal_alignment.to_u32).to_s),
                "verticalAlignment"   => JSON::Any.new(Gtk::Align.new(vertical_alignment.to_u32).to_s),
                "orientation"         => JSON::Any.new(Gtk::Orientation.new(orientation.to_u32).to_s),
              } of String => JSON::Any

              image = Elements::Image.new(attributes, [] of Elements::Node)
              widget = image.build_widget(parent_widget)

              env.push_pointer ::Box.box widget
              env.call_success

              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__HorizontalSeparator", 3) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0
              class_name = env.require_string 1
              parent_widget = ::Box(Gtk::Widget).unbox(env.require_pointer(2))

              attributes = {
                "id"        => JSON::Any.new(id),
                "className" => JSON::Any.new(class_name),
              } of String => JSON::Any

              horizontal_separator = Elements::HorizontalSeparator.new(attributes, [] of Elements::Node)
              widget = horizontal_separator.build_widget(parent_widget)

              env.push_pointer ::Box.box widget
              env.call_success
            rescue exception : Exception
              Log.error(exception: exception) { exception.message }
              env.call_failure
            end
          end

          sandbox.push_global_proc("UserInterface__VerticalSeparator", 3) do |ptr|
            env = Duktape::Sandbox.new ptr

            begin
              id = env.require_string 0
              class_name = env.require_string 1
              parent_widget = ::Box(Gtk::Widget).unbox(env.require_pointer(2))

              attributes = {
                "id"        => JSON::Any.new(id),
                "className" => JSON::Any.new(class_name),
              } of String => JSON::Any

              vertical_separator = Elements::VerticalSeparator.new(attributes, [] of Elements::Node)
              widget = vertical_separator.build_widget(parent_widget)

              env.push_pointer ::Box.box widget
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

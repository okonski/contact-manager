module ContactManager
  module BuilderWidgetable
    extend ActiveSupport::Concern
    
    included do
      attr_accessor :window
    end
    
    module InstanceMethods
      def ui
        @ui ||= Gtk::Builder.new.add_from_file(File.expand_path("ui/#{self.class.to_s.split("::").last.downcase + '.ui'}"))
      end
    end
  end
end

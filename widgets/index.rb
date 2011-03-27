module ContactManager
  module Widgets
    class Index
      attr_accessor :ui, :window
      
      def initialize
        @ui = Gtk::Builder.new
        @ui.add_from_file File.expand_path("ui/index.ui")
        
        @window = @ui.get_object "window1"
        
        super

        @contactView = @ui.get_object "ContactView"
        @contactView.headers_visible = true
        @contactView.headers_clickable = true
        @contactView.selection.mode = Gtk::SELECTION_BROWSE
        
        renderer = Gtk::CellRendererText.new
        col1 = Gtk::TreeViewColumn.new("ID", renderer, :text => 0)
        col2 = Gtk::TreeViewColumn.new("Name", renderer, :text => 1)
        col3 = Gtk::TreeViewColumn.new("Age", renderer, :text => 2)
        @contactView.append_column col1
        @contactView.append_column col2
        @contactView.append_column col3
        @contactView.signal_connect "row-activated" do |view, path, column|
          showPopup(view.selection.selected)
        end
        
        @contactStore = @ui.get_object "ContactStore"
        @contactView.model = @contactStore
        
        @showButton = @ui.get_object "ShowButton"
        @showButton.signal_connect "clicked" do
          selected = @contactView.selection.selected
          showPopup selected
        end
        
        @quitButton = @ui.get_object "QuitButton"
        @quitButton.signal_connect "clicked" do
          destroy
        end
        
        @window.signal_connect "destroy" do
          Gtk.main_quit
        end
        
        showContacts
        
        @window.set_title "Index"
        @window.show_all
      end
      
      protected
        def showContacts
          @contactStore.clear
          ::User.all.each do |user|
            iter = @contactStore.append
            iter[0] = user.id
            iter[1] = user.name
            iter[2] = user.age
          end          
        end
        
        def showPopup selection
          dialog = Gtk::MessageDialog.new(@window, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::INFO, Gtk::MessageDialog::BUTTONS_CLOSE, "You have selected #{selection[1]}.")
          dialog.run
          dialog.destroy
        end
    end
  end
end

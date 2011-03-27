module ContactManager
  module Widgets
    class Index < Gtk::Window  
      def initialize
        super
        
        @verticalLayout = Gtk::VBox.new
        
        @contactView = Gtk::TreeView.new
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
        
        @contactStore = Gtk::ListStore.new Integer, String, Integer
        @contactView.model = @contactStore
        
        @verticalLayout.pack_start @contactView
        
        @showButton = Gtk::Button.new "Show"
        @showButton.signal_connect "clicked" do
          selected = @contactView.selection.selected
          showPopup selected
        end
        
        @quitButton = Gtk::Button.new "Quit"
        @quitButton.signal_connect "clicked" do
          destroy
        end
        
        @buttonBox = Gtk::HButtonBox.new
        
        @buttonBox.pack_start @showButton
        @buttonBox.pack_start @quitButton
                
        @verticalLayout.pack_start @buttonBox
        
        signal_connect "destroy" do
          Gtk.main_quit
        end
        
        showContacts
        
        set_title "Index"
        add @verticalLayout
        show_all
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
          dialog = Gtk::MessageDialog.new(self, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::INFO, Gtk::MessageDialog::BUTTONS_CLOSE, "You have selected #{selection[1]}.")
          dialog.run
          dialog.destroy
        end
    end
  end
end

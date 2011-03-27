module ContactManager
  module Widgets
    class Index
      include ::ContactManager::BuilderWidgetable
      
      def initialize
        @window = ui.get_object "window1"

        @contactView = ui.get_object "ContactView"
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
          show view.selection.selected
        end
        
        @contactStore = ui.get_object "ContactStore"
        @contactView.model = @contactStore
        
        @showButton = ui.get_object "ShowButton"
        @showButton.signal_connect "clicked" do
          selected = @contactView.selection.selected
          show selected
        end
        
        @quitButton = ui.get_object "QuitButton"
        @quitButton.signal_connect "clicked" do
          @window.destroy
        end
        
        @createButton = ui.get_object "CreateButton"
        @createButton.signal_connect "clicked" do
          show -1
        end
        
        @window.signal_connect "destroy" do
          Gtk.main_quit
        end
        
        refresh
        
        @window.set_title "Index"
        @window.show_all
      end
      
      def refresh
        @contactStore.clear
        User.all.each do |user|
          iter = @contactStore.append
          iter[0] = user.id
          iter[1] = user.name
          iter[2] = user.age
        end          
      end
       
      def show contact
        Widgets::Contacts::Resource.new(contact[0], self)
      end
    end
  end
end

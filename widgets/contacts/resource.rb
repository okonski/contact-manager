module ContactManager
module Widgets
  module Contacts
    class Resource
      include BuilderWidgetable
      attr_accessor :contact, :parent
      
      def initialize(contact_id, parent = nil)
        @contact = User.find(contact_id) rescue User.new
        @parent = parent
        @window = ui.get_object "ShowContactWindow"
        
        @idEntry = ui.get_object "IDEntry"
        @nameEntry = ui.get_object "NameEntry"
        @ageEntry = ui.get_object "AgeEntry"
        refresh
        
        @quitButton = ui.get_object "QuitButton"
        @quitButton.signal_connect "clicked" do
          @window.destroy
        end
        
        @saveButton = ui.get_object "SaveButton"
        @saveButton.signal_connect "clicked" do
          save
        end
        
        @deleteButton = ui.get_object "DeleteButton"
        @deleteButton.signal_connect "clicked" do
          destroy
        end
        
        @window.show
      end
      
      def new?
        @contact.new_record?
      end
      
      def refresh_parent
        @parent.refresh if @parent
      end

      def refresh
        @idEntry.text = @contact.id.to_s
        @nameEntry.text = @contact.name
        @ageEntry.text = @contact.age.to_s
      end
        
      def save
        @contact.name = @nameEntry.text
        @contact.age = @ageEntry.text.to_i
        @contact.save
        refresh
        refresh_parent
      end
      
      def destroy
        @window.destroy
        @contact.destroy
        refresh_parent
      end
    end
  end
end
end

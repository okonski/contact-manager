module ContactManager
  module Widgets
    class Show
      include BuilderWidgetable
      attr_accessor :contact, :parent
      
      def initialize(contact_id, parent = nil)
        @contact = User.find(contact_id)
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
        
        @window.show
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
        @parent.refresh if @parent
      end
    end
  end
end

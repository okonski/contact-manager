class HelloWidget < Gtk::Window
  attr_accessor :number
  
  def initialize
    super
    @number = 0
    
    @addButton = Gtk::Button.new "Dodaj"
    @addButton.signal_connect "clicked" do
      @number += 1
      showNumber
    end
    
    @subtractButton = Gtk::Button.new "Odejmij"
    @subtractButton.signal_connect "clicked" do
      @number -= 1
      showNumber
    end
    
    @counter = Gtk::Entry.new
    @counter.editable = false
    
    @hbox = Gtk::HBox.new
    @hbox.pack_start @addButton
    @hbox.pack_start @subtractButton
    @vbox = Gtk::VBox.new
    @vbox.pack_start @hbox
    @vbox.pack_start @counter
    
    signal_connect "destroy" do
      Gtk.main_quit
    end
    
    title = "Hello"
    showNumber    
    add @vbox
    show_all
  end
  
  def showNumber
    @counter.text = @number.to_s
  end
end

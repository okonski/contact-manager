#!/usr/bin/env ruby

$:.unshift './'

require 'bundler'
Bundler.setup

require 'active_support/all'
require 'active_record'
require 'gtk2'

ActiveRecord::Base.establish_connection\
  :adapter => 'sqlite3', 
  :database => 'development.db'

ActiveRecord::Migrator.migrate('migrations', nil)

module ContactManager  
  autoload :BuilderWidgetable, "lib/builder_widgetable"
  
  Dir["models/*.rb"].collect {|n| File.basename n, ".*" }.each do |file|
    autoload file.camelize.to_sym, "models/#{file}"
  end
  
  module Widgets    
    Dir["widgets/*.rb"].collect {|n| File.basename n, ".*" }.each do |file|
      autoload file.camelize.to_sym, "widgets/#{file}"
    end
  end
end

#User.create! :name => "Sheldon Cooper", :age => 25

index = ContactManager::Widgets::Index.new
index.window.show

Gtk.main

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

require "lib/builder_widgetable"
  
Dir["models/*.rb"].collect {|n| File.basename n, ".*" }.each do |file|
  require "models/#{file}"
end
  
Dir["widgets/*.rb"].collect {|n| File.basename n, ".*" }.each do |file|
  require "widgets/#{file}"
end

#User.create! :name => "Sheldon Cooper", :age => 25

index = ContactManager::Widgets::Contacts::Collection.new
index.window.show

Gtk.main

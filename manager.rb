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

require 'widgets/hello'

hello = HelloWidget.new
hello.show

Gtk.main

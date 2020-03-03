require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'interactive_record.rb'

class Student < InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end 
  
  def self.column_names
    DB[:conn].results_as_hash = true
    sql = "pragma table_info('#{table_name}') "
    table_info  = DB[:conn].execute(sql)
    column_names=[]
    table_info.each do |row|
      column_names << row["name"]
  end 
  column_names.compact
end 
self.column_names.each do |col_names|
  attr_accessor col_names.to_sym
end 

def initialize(options = {})
options.each do |property,value|
  self.send("#{property}=",value)
end
end 
def table_name_for_insert
  self.class.table_name
end 
def col_name_for_instance
end 
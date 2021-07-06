require 'pry' 

class Course
  attr_accessor :title, :schedule, :description
  
  @@all_courses = []
  
  def initialize
    @title = title
    @schedule = schedule
    @description = description
    @@all_courses << self
  end

  def self.all 
    @@all_courses
  end
  
  def self.reset_all
    @@all_courses = []
  end
  
end


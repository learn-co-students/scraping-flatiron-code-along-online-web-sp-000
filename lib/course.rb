class Course
  attr_accessor :title, :schedule, :description

  COURSES = []
  def self.all
    COURSES
  end
  def self.reset_all
    COURSES.clear
  end

  def initialize
    COURSES << self
  end
end

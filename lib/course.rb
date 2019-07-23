class Course
  attr_accessor :title, :schedule, :description
  @@all = []
  def initialize
    @@all << self
  end
  def title(title)
    #setter and getter method for title
    @title = title
  end
  def title
    @title
  end
  def schedule(schedule)
    #setter and getter method for a course's schedule
    @schedule = schedule
  end
  def schedule
    @schedule
  end
  def description(description)
    #seter and getter method for course's description
    @description = description
  end
  def description
    @description
  end
  def self.all
    # returns an array of all the instances of the Course's class
    @@all
  end
  def self.reset_all
    @@all.clear
  end
end

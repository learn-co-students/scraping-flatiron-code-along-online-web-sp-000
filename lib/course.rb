class Course
  attr_accessor :title, :schedule, :description
  @@all = []

  def initialize
    @@all << self           #Every time an instance of the class is initialized, we should push it into the @@all
  end

  def self.all
    return  @@all           #return class var array
  end

  def self.reset_all
    @@all.clear             #clears class var array
  end
end

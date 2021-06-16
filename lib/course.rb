
#defines a Course class which sets and gets 3 attributes (inherently linked inside scraper)
#and keeps track of itself like all good little class' seem too

class Course
  attr_accessor :title, :schedule, :description
  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset_all
    @@all.clear
  end


end

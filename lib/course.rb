class Course
  attr_accessor :title, :schedule, :description
  @@all = []

  def initialize
    save << self
  end

  def self.all
    @@all
  end

  def self.reset_all
    all.clear
  end

  private
    def save
      self.class.all
    end
end


require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    @doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    return @doc
  end

  def get_courses
    self.get_page
    @coursesHTML = @doc.css(".post")
    return @coursesHTML
  end

  def make_courses
    self.get_courses
    @coursesHTML.each do | object |
    #  binding.pry
      newCourse = Course.new
      newCourse.title = object.css("h2").text
      newCourse.description = object.css("p").text
      newCourse.schedule = object.css(".date").text
    end
  end

end

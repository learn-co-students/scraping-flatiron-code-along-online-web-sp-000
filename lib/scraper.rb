require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end
  
  def get_courses
    get_page.css("article")
  end
  
  def make_courses
    new_course=Course.new
    get_courses.each do |course|
      new_course.title=course.css("h2").text
      new_course.schedule=course.css(".date").text
      new_course.description=course.css("p").text
    end
    new_course
  end
  
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
  
end




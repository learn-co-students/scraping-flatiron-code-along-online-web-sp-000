require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end
  
  def get_courses
    get_page.css("h2")
  end
  
  def make_courses
    get_courses.each do |course|
      new_course = Course.new
      new_course.title = course.search("h2").text
      new_course.schedule = course.search(".date").text
      new_course.description = course.search(".date p").text
    end
  end
  
  def print_courses
    make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end




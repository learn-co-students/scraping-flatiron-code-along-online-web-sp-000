require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  def get_page
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    Nokogiri::HTML(html)
  end 
  def get_courses
    page = get_page
    page.css(".posts-holder")
  end 
  def make_courses
    courses = get_courses
    courses.each do |c|
      course = Course.new 
      course.title = c.css("h2").text
      course.schedule = c.css(".date").text
      course.description = c.css("p").text
    end 
  end
end




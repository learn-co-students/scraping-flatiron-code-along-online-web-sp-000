require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  # calls .make_courses, iterates over them, and puts out list
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
  
  # uses Nokogiri and open-uri to grab HTML doc from web page
  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

  #doc.css(".post").each do |post|
  #course = Course.new
  #course.title = post.css("h2").text
  #course.schedule = post.css(".date").text
  #course.description = post.css("p").text
    #end
  end
  
  # uses CSS selector to grab HTML elements containing a course
  def get_courses
    self.get_page.css(".post")
  end
  
  # instantiates Course objects with title, schedule, description
 
  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
    course.schedule = post.css(".date").text
    course.description = post.css("p").text
    end
  end


  
end

Scraper.new.print_courses


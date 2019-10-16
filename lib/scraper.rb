require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def get_page #responsible for getting the code in the HTML document
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end
  
  def get_courses #operate on HTML page (the return value of #get_page) and return collection of elements for each course
    self.get_page.css(".post")
  end
  
  def make_courses
     self.get_courses.each do |post| #for each iteration of elements returned by doc.css(".post") line, we are making a new instance of course and giving it a title, schedule, description
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
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

Scraper.new.get_page
Scraper.new.print_courses


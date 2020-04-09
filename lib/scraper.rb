require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

 #get_page: Responsible for using Nokogiri and open-uri to grab the entire HTML document from the web page.

#get_courses: Calls on .make_courses and then iterates over all of the
#Courses that get created to puts out a list of course offerings.

#make_courses: Responsible for actually instantiating Course objects and giving
#Each course object the correct title, schedule and description attribute that we scraped from the page.

#print_courses: Responsible for using a CSS selector to grab all of the HTML elements that contain a course.
#The return value of this method should be a collection of Nokogiri XML elements, each of which describes a course offering.

class Scraper

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    self.get_courses.each do |post|
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

Scraper.new.print_courses

require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

#print courses method calls on make courses method and iterates over all of the courses that get created to puts out a list of course offerings.
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

#using Nokogiri and open-URI to grab the entire HTML document
def get_page
  doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
#for each iteration over the collection of Nokogirl XML elements returned to us by the doc.css(".post") line, we are making a new instance of the Course class and giving that instance the title, schedule and description extracted from the XML.
  #doc.css(".post").each do |post|
      #course = Course.new
    #  course.title = post.css("h2").text
    #  course.schedule = post.css(".date").text
    #  course.description = post.css("p").text
      #end
end

#using a CSS selector to grab all the HTML elements that contain a course. collection of NOKOGIRI XML elements.
def get_courses
  self.get_page.css(".post")
end

#instantiating Course objects and giving each course object the correct title, scheudle, and description attribute that we scraped from the page.
#The #make_courses method should operate on the collection of course offering Nokogiri XML elements that was returned by the .get_courses method. The .make_courses method should iterate over the collection and make a new instance of Course class for each one while assigning it the appropriate attributes:

def make_courses
  self.get_courses.each do |post|
        course = Course.new
        course.title = post.css("h2").text
        course.schedule = post.css(".date").text
        course.description = post.css("p").text
      end
    end


end

#That way, we'll hit our binding and be able to play around with the HTML document in the terminal in order to find the CSS selectors we're looking for:
#Scraper.new.get_page
Scraper.new.print_courses
#Once you hit your binding, type the doc variable into the terminal and you should see the HTML document, retrieved for us by Nokogiri and open-uri.

#Inspect element. Looks like the element that contains an individual course has a class of "post". Let's use this CSS selector of .post to try to grab all courses.
#In terminal: doc.css(".post")

#We know that a collection of Nokogiri XML elements functions like an array.

#In your terminal, execute doc.css(".post").first. This will grab us just the first element from the collection: shows title, schedule, and description.
#doc.css(".post").first.css("h2").text to find course title in terminal
#doc.css(".post").first.css(".date").text to find schedule and description
#doc.css(".post").first.css("p").text return: "An intensive, Ruby and Javascript course that teaches the skills necessary to start a career as a full-stack software developer."

require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

#retrieves the page which is HARD LINKED, alternatively this would be called on URL:
#allowing for a more abstract, less breakable version

  # def get_page(url)
  #   Nokogiri::HTML(url)
  # end

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

#runs get page on itself dividing the page out @ the CSS class <"post">
  def get_courses
    self.get_page.css(".post")
  end

#iterates over each element in the page to yank the information needed to scrape
#courses from Flatiron itself. Which leads me to my theory, now stick with me:
#why does flatiron keep making people scrape thier own web page??? HUH!! FOR
#INFORMATION THEY ALREADY HAVE!!!! Ill tell you why.

#illicit, page view counter manipulation.

#I cant be sure whats going on here, why the blatant tampering.
#but I am sure of one thing..

#somethings not right here.
  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
     end
  end







#given to us by the Flatiron God's this default method prints out an informative
#display of all of the collected information from the scrape.
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "Schedule: #{course.schedule}"
        puts "Description: #{course.description}"
      end
    end
  end

end

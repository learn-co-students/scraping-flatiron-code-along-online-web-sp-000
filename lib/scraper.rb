require 'pry'

require 'nokogiri'
require 'open-uri'


require_relative './course.rb'

class Scraper
  def get_page
    #html = open('http://learn-co-curriculum.github.io/site-for-scraping/courses') 
    #this holds the html code in this variable called html
    
    doc = Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses')) 
    
    #this turns the html into nodes 
     
     doc.css(".post").each do |post|
       course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
      binding.pry 
      
    end
  end
  end
  
  
  # def get_courses 
  
#   doc.css(".post").first.css("h2").text
# => "Web Development Immersive"
# doc.css(".post").first.css(".date").text
# => "Full-Time"
# doc.css(".post").first.css("p").text
# => "An intensive, Ruby and Javascript course that teaches the skills necessary to start a career as a full-stack software developer."

 def make_courses
   
  # def print_courses
  #   self.make_courses
  #   Course.all.each do |course| 
  #     if course.title && course.title != ""
  #       puts "Title: #{course.title}"
  #       puts "  Schedule: #{course.schedule}"
  #       puts "  Description: #{course.description}"
  #     end
   # end 
  end

Scraper.new.get_page

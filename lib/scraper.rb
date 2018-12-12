require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './course.rb'

class Scraper
  attr_accessor :page, :courses
  
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
    Nokogiri::HTML(open("https://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end
  
  def get_courses
    @courses = self.get_page.css(".post")
  end
  
  def make_courses
    self.get_courses.each do |post|
      Course.new(post.css("h2").text,
                 post.css(".date").text,
                 post.css("p").text)
    end
  end
end




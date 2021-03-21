require 'pry'

require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  def get_page
    doc = Nokogiri::HTML(html)
    html = open('http://learn-co-curriculum.github.io/site-for-scraping/courses.')
    
  end 
#   Nokogiri - Parsing HTML in Ruby
# www.rubyguides.com › 2012 › 01

  
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




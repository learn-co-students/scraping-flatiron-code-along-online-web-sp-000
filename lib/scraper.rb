require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page
    html = open('https://learn-co-curriculum.github.io/site-for-scraping/courses')
    Nokogiri::HTML(html)
  end

  def get_courses
    html = get_page
    html.css('.posts-holder').css('.post')
    # get_page.css('.posts-holder')
  end

  def make_courses
    get_courses.each {|e| 
      course = Course.new
      course.schedule =  e.css('.date').text
      course.title = e.css('h2').text
      course.description = e.css('p').text
    }
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




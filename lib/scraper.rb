require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

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

  def get_page
    # doc = Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
    Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
  end

  def get_courses
    # courses = self.get_page.css('.post')
    self.get_page.css('.post')
  end

  def make_courses
    self.get_courses.each do |listing|
      course = Course.new
      course.title = listing.css('h2').text
      course.schedule = listing.css('.date').text
      course.description = listing.css('p').text
    end
  end

end

# Scraper.new.print_courses

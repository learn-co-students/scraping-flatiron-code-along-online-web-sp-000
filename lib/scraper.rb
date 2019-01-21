require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  @@url = "http://learn-co-curriculum.github.io/site-for-scraping/courses"

  def get_page
    @html = open(@@url)
    @doc = Nokogiri::HTML(@html)
  end

  def get_courses
    get_page
    @doc.css('#course-grid .posts-holder .post')
  end

  def make_courses
    get_courses.each do |course|
      new_course = Course.new
      new_course.title = course.css('h3').text
      new_course.schedule = course.css('.date').text
      new_course.description = course.css('p').text
    end
  end

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

end

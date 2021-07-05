require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    get_page.css(".posts-holder article")
  end

  def make_courses
    get_courses.each do |course|
      if course.children[3]
        new_course = Course.new
        new_course.title = course.children[3].text
        new_course.schedule = course.children[5].text
        new_course.description = course.children[7].text
      end
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

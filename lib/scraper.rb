require "open-uri"
require "nokogiri"

require_relative "./course.rb"

class Scraper

	def get_page
		Nokogiri::HTML(URI.open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
	end

	def get_courses
		get_page.css("#course-grid .post")
	end

	def make_courses
		get_courses.each do |course|
			program = Course.new
			program.title = course.css("h2").text.strip
			program.schedule = course.css(".date").text.strip
			program.description = course.css("p").text.strip
		end
	end

	def print_courses
		make_courses

		Course.all.each do |course|
			if course.title && course.title != ""
				puts "Title: #{course.title}"
				puts "  Schedule: #{course.schedule}"
				puts "  Description: #{course.description}"
				puts
			end
		end
	end

end

Scraper.new.print_courses

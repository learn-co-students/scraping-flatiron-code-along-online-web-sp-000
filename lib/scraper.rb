require 'nokogiri'
require 'open-uri'

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
    therawhtml = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    #this fetch the html
    result = Nokogiri::HTML(therawhtml)
  end

  def get_courses
    doc = get_page
    #this get u the node set of everything. in xml format
    doc.css("article") #fetches a list of elements with class post
    #it looks like if we just do .post it will get some extra empty stuff which doesnt have children. which will break the loop
    #but how do i select two classes at the same level, not one class nested inside another.
    #CURRENTYL i can't get it. it returns nothing
    #even if i change to one class, but itf it's not post, it still retursn nothing. what the heckkkk

    #note: if u try to puts this it only show the HTML
    #u need to do p doc.css... to see the entire list of xml objects
end

  def make_courses
    # puts get_courses
    # puts "newline"
    # puts "newline"

    # puts "landmark"
    # puts hi
    # puts hi2
    # puts hi3
    # p get_courses[0].attributes
    # puts "newline"
    # p get_courses[8].attributes["class"].value


    get_courses.each do | course |
        #  puts course.children[3].name
        #  puts course
        #  puts "new lineeeeeee"
        if !course.attributes["class"].value.include?("empty-event") #to test if the "course" is indded a course and not unwanted stuff
          #long story short. we need it to not have the empty-event class
          newcourse = Course.new
          newcourse.title =  course.children[3].text #h2 element. title
          newcourse.schedule =  course.children[5].text #em element. fulltime partime
          newcourse.description =  course.children[7].text #p element. description
        end #end if
      end #end iteration
    end #end method

end #end class

# testpiece = Scraper.new("http://learn-co-curriculum.github.io/site-for-scraping/courses")
# testpiece.make_courses

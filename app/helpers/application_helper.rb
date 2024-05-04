module ApplicationHelper
    def display_author(content)
      author_string = "<p>Author: "
      if content.user.nil?
        author_string += "Deleted User"
      else
        author_string += content.user.username
      end
      author_string += "</p>"
      author_string.html_safe
    end
  end
  
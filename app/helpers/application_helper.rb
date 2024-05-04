module ApplicationHelper
    def display_author(content_user)
      author_string = "Author: "
      if content_user.nil?
        author_string += "Deleted User"
      else
        author_string += content_user.username
      end
      content_tag(:p, author_string)
    end
  end
  
module Visible
  extend ActiveSupport::Concern
  included do
    enum status: {
      displayed: "displayed",
      hidden: "hidden",
      archived: "archived"
    }
  end
  class_methods do
    def public_count
      self.displayed.count
    end
  end
end

class Article < ApplicationRecord
  # has_rich_text :description
  validates :title, presence: true, length: {minimum: 6, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 500}

end
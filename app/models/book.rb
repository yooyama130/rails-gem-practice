class Book < ApplicationRecord
  acts_as_taggable

  validates :title, presence: true, length: { minimum: 2}
  validates :introduction, presence: true
end

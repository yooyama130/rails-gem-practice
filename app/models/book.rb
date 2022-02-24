class Book < ApplicationRecord
  acts_as_taggable

  validates :title, presence: true
  validates :introduction, presence: true
end

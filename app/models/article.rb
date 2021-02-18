class Article < ActiveRecord::Base
  validates :title, :content, presence: true
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
  validates :content, length: { maximum: 200000 }
end

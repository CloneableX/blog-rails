class Article < ActiveRecord::Base
  validates :title, :content, presence: true
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
  validates :content, length: { maximum: 200000 }

  belongs_to :catalog

  after_create { catalog.increase_articles_num if catalog }
  after_destroy { catalog.minus_articles_num if catalog }

  def self.list
    Article.includes(:catalog).select(:id, :title, :description, :catalog_id).order('updated_at desc')
  end

  def self.paginate(page)
    self.list.page(page)
  end

end

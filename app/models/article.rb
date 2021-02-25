class Article < ActiveRecord::Base
  validates :title, :content, presence: true
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
  validates :content, length: { maximum: 200000 }

  belongs_to :catalog

  after_create :increase_articles_num
  after_destroy :minus_articles_num

  def self.list
    Article.includes(:catalog).select(:id, :title, :description, :catalog_id).order('updated_at desc')
  end

  def self.paginate(page)
    self.list.page(page)
  end

  private
  
    def increase_articles_num
      return true unless catalog_id
      catalog.articles_num += 1
      catalog.save
    end

    def minus_articles_num
      return true unless catalog
      catalog.articles_num -= 1
      catalog.save
    end
  
end

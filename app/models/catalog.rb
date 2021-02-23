class Catalog < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }

  has_many :articles

  before_destroy :ensure_not_reference_article

  private

    def ensure_not_reference_article
      raise 'Articles present!' unless articles.empty?
      return true
    end
end

class BlogController < ApplicationController
  def index
    @articles = Article.select(:id, :title, :description).order("updated_at desc")
  end
end

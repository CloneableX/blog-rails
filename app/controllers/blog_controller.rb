class BlogController < ApplicationController
  skip_before_action :authorize
  
  def index
    @articles = Article.select(:id, :title, :description).order("updated_at desc")
  end
end

class BlogController < ApplicationController
  skip_before_action :authorize
  
  def index
    @articles = Article.list
  end
end

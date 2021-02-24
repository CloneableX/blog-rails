require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post :create, article: { content: @article.content, description: @article.description, title: @article.title, catalog_id: catalogs(:one).id }
    end

    assert_redirected_to article_path(assigns(:article))
    assert_not_nil assigns(:article).catalog
  end

  test "should show article" do
    get :show, id: @article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article
    assert_response :success
  end

  test "should update article" do
    patch :update, id: @article, article: { content: @article.content, description: @article.description, title: @article.title }
    assert_redirected_to article_path(assigns(:article))
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to articles_path
  end

  test "should redirect to login page when editing articles without logining" do
    logout
    get :edit, id: @article
    assert_redirected_to login_path
    assert_equal 'Please sign in!', flash[:notice]
  end

  test "should search articles by title" do
    post :search, title: @article.title
    assert_response :success
    titles = assigns(:articles).collect { |article| article.title }
                                .select { |title| title.include?(articles(:one).title) }
    assert_equal assigns(:articles).size, titles.size                            
  end

  test "should search articles by catalog" do
    get :catalog, catalog_id: @article.catalog.id
    assert_response :success

    catalog_ids = assigns(:articles).collect { |article| article.catalog.id }
                       .select { |catalog_id| catalog_id == @article.catalog.id }
    assert !catalog_ids.empty?                   
  end
end

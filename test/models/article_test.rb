require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should be valid when content and title is presence" do
    article = Article.create(title: 'test title', content: 'test content')
    assert article.valid?
  end

  test "should be invalid when title is more than 50" do
    assert validate_article_field_length({ title: generate_string(50) }).invalid?
    assert validate_article_field_length({ title: generate_string(49) }).valid?
  end

  test "should be invalid when description is more than 200" do
    assert validate_article_field_length({ description: generate_string(200) }).invalid?
    assert validate_article_field_length({ description: generate_string(199) }).valid?
  end

  test "should be invalid when content is more than 200000" do
    assert validate_article_field_length({ content: generate_string(200000) }).invalid?
    assert validate_article_field_length({ content: generate_string(199999) }).valid?
  end

  test "should return articles without content field" do
    articles = Article.list
    assert articles.first.attributes.exclude?(:content)
  end

  test "should paginating articles" do
    articles = (1..30).collect { {title: 'Introduce', content: 'Introduce ...' } }
    Article.create(articles)

    articles_page = Article.paginate(2)
    
    assert_equal 10, articles_page.size
    assert_equal Article.count, articles_page.total_count
    assert_equal 4, articles_page.total_pages
  end

  test "should catalog articles number increase one when create article" do
    article = Article.new(title: 'Introduce', content: 'Introduce...', catalog_id: catalogs(:one).id)
    articles_num = article.catalog.articles_num
    article.save
    assert_equal articles_num + 1, article.catalog.articles_num
  end

  test "should catalog articles number subtract one when destroy article" do
    article = articles(:one)
    articles_num = article.catalog.articles_num
    article.destroy

    assert_equal articles_num - 1, Catalog.find(article.catalog_id).articles_num
  end

  test "should destroy success when catalog don't bind catalog" do
    article = articles(:two)
    article.destroy
  end

  private

    def validate_article_field_length(valid_field_hash)
      Article.create({
        title: 'valid title',
        content: 'valid content'
      }.merge(valid_field_hash))
    end
end

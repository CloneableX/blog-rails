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
  private

    def validate_article_field_length(valid_field_hash)
      Article.create({
        title: 'valid title',
        content: 'valid content'
      }.merge(valid_field_hash))
    end
end

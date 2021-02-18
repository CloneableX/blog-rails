require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should be valid when content and title is presence" do
    article = Article.create(title: 'test title', content: 'test content')
    assert article.valid?
  end

  test "should be invalid when title is more than 50" do
    assert validate_article_field_length({ title: generate_string(50) }).invalid?
  end

  test "should be invalid when description is more than 200" do
    assert validate_article_field_length({ description: generate_string(200) }).invalid?
  end

  test "should be invalid when content is more than 1000" do
    assert validate_article_field_length({ content: generate_string(1000) }).invalid?
  end

  private
    def generate_string(length)
      (1..length + 1).map { 'a' }.join
    end

    def validate_article_field_length(valid_field_hash)
      Article.create({
        title: 'valid title',
        content: 'valid content'
      }.merge(valid_field_hash))
    end
end

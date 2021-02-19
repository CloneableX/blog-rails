require "test_helper"

class ArticlesHelperTest < ActionView::TestCase
  test "should convert markdown to html" do
    html = markdown_to_html('# This is Markdown')
    assert_match /<h1>This is Markdown<\/h1>\s/, raw(html)
  end
end
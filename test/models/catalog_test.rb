require 'test_helper'

class CatalogTest < ActiveSupport::TestCase
  test "should be invalid when title is empty" do
    catalog = Catalog.create()
    assert catalog.invalid?
  end

  test "should be invalid when title's length greater than 50 characters" do
    catalog = Catalog.create(title: generate_string(50))
    assert catalog.invalid?
  end

  test "should be valid when tilte's length less than and equal 50 characters" do
    catalog = Catalog.create(title: generate_string(49))
    assert catalog.valid?
  end

  test "should destroy failed when catalog assigned with any articles" do
    exception = assert_raise(StandardError) {
      Catalog.destroy(articles(:one).catalog.id)
    }
    assert_equal 'Articles present!', exception.message
  end

end

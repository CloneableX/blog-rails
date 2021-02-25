class AddArticlesNumToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :articles_num, :int, default: 0
  end
end

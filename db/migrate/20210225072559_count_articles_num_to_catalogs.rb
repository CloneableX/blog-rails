class CountArticlesNumToCatalogs < ActiveRecord::Migration
  def up
    catalogs = {}
    Catalog.all.each do |catalog|
      catalogs[catalog.id] = { articles_num: catalog.articles.size }
    end
    Catalog.update(catalogs.keys, catalogs.values)
  end

  def down
    Catalog.where("articles_num > 0").update_all(articles_num: 0)
  end
end

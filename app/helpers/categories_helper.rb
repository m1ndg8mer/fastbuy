module CategoriesHelper
  def get_title_by_id id
    Category.find(id).title
  end
end

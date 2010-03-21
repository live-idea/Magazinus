# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_category_path
    path = ""
    path << link_to("Всі категорії", categories_path)

    @parents_categories.each do|c|
      path << " / "
      if @parents_categories.last == c
        path << c.title
      else
        path << link_to(c.title, categories_path(:parent=>c.id))
      end

    end
    path
  end
end

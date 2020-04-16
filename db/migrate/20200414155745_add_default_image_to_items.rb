class AddDefaultImageToItems < ActiveRecord::Migration[5.1]
  def change
    change_column_default :items, :image, "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.123rf.com%2Fstock-photo%2Fno_image_available.html&psig=AOvVaw30kiGxMy2gbAtnTgpSwWu0&ust=1586966141754000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKiq-9qj6OgCFQAAAAAdAAAAABAD"
  end
end

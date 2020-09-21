# frozen_string_literal: true

class ChangeImageToPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :image, :text
    add_column :posts, :image_url, :text
  end
end

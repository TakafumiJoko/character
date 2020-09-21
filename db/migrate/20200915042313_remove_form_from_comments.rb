# frozen_string_literal: true

class RemoveFormFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :form, :string
  end
end

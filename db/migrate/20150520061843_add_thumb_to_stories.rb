class AddThumbToStories < ActiveRecord::Migration
  def change
    add_column :stories, :thumb, :string
  end
end

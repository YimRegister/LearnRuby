class RelateImagestoUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :images, :user, index: true
  end
end

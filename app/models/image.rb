class Image < ApplicationRecord
   belongs_to :user
   after_save {id = self.id}
end

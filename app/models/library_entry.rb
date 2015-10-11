class LibraryEntry < ActiveRecord::Base
  validates :name, uniqueness: { scope: :hm_id}
  belongs_to :user
  belongs_to :anime
end

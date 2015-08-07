class LibraryEntry < ActiveRecord::Base
  validates :name, uniqueness: { scope: :slug}
  belongs_to :user
  belongs_to :anime
end
class Anime < ActiveRecord::Base
  validates :hm_id, presence: true
  validates :hm_id, uniqueness: true

  has_many :library_entries
  has_many :users, through: :library_entries
  has_and_belongs_to_many :genres
end

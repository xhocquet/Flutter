class User < ActiveRecord::Base
  validates :name, :time_spent_on_anime, presence: true

  has_many :library_entries
  has_many :animes, through: :library_entries
end

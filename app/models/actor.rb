class Actor < ApplicationRecord
  has_many :movie_actors, -> {order('id')}
  has_many :movies, through: :movie_actors
  accepts_nested_attributes_for :movie_actors
end

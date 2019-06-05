class MovieActor < ApplicationRecord
  belongs_to :actor, inverse_of: :movie_actors
  belongs_to :movie
end

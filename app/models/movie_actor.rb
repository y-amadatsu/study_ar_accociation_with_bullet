class MovieActor < ApplicationRecord
  belongs_to :actor
  belongs_to :movie

  accepts_nested_attributes_for :actor
end

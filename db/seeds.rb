# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  Movie.create({ name: Faker::Book.title})
end

movie_ids = Movie.all.map do |m|
  {movie_id: m.id}
end

10.times do
  Actor.create({
    name: Faker::JapaneseMedia::OnePiece.character,
    movie_actors_attributes: movie_ids.sample(rand(movie_ids.size)+1)
  })
end
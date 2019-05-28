# README

bundle install --path vendor/bundle

## model

Actor
- name

Movie
- name

MovieActor
- actor_id
- movie_id

## model(accociation)

```
class Actor < ApplicationRecord
  has_many :movie_actors, -> {order('id')}
  has_many :movies, through: :movie_actors
  accepts_nested_attributes_for :movie_actors
end

class Movie < ApplicationRecord
end

class MovieActor < ApplicationRecord
  belongs_to :actor
  belongs_to :movie
end
```

## 質問

以下の呼び出しで、

http://localhost:3000/index4

http://localhost:3000/index11

なぜbullet警告エラーとなるのか？

そして、
http://localhost:3000/index12

はなぜbullet:OKなのか。

bulletのバグの可能性もあるけど、基本的な使い方なのが気にかかるところ…
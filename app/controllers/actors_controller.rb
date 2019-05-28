class ActorsController < ApplicationController
  # bullet:NG 単純にやるとN+1警告がでる
  def index1
    @actors = Actor.all
    render template: 'actors/index'
  end

  # bullet:OK 警告に沿ってかつ、実際に参照しているのでOKだが、ソートしたい。どうしても。ソートしたい。
  # あと、movie, actorと主に件数がめちゃ多くなるとSQL文がめっちゃ長くなるのが嫌。
  def index2
    @actors = Actor.includes(:movies).all
    render template: 'actors/index'
  end

  # bullet:OK modelにsort付けているからいいかな、と思ったらmovieのソートができない
  def index3
    @actors = Actor.includes(:movies).all.order('actors.id')
    render template: 'actors/index'
  end

  # ★★多分、ここで諦めたほうがよかったと思います。movieのソートぐらいViewとかでやれって意味で。
  # ただ、簡単にmovieでソートできそうっだったのでやってみたら地獄見た。

  # bullet:NG SQL的には想定どおり組み立てられ、画面もOKなのでよいのだがBulletがNGはになる。。。誤検知？
  def index4
    @actors = Actor.includes(:movies).joins(:movies).all.order('actors.id, movies.id')
    render template: 'actors/index'
  end

  # bullet:NG ソートを外してみたけどだめ。すでにこの形でだめ。
  def index5
    @actors = Actor.includes(:movies).joins(:movies).all
    render template: 'actors/index'
  end
  

  # bullet:OK 言われるままに movie_actors をincludeしてみた。おお、よさげ?と思ったら、
  # SQLで無駄に movie_actors を２度 inner join されてしまいSQLの結果セットの件数がめちゃ増えた…
  def index6
    @actors = Actor.includes(:movies).joins(:movies).includes(:movie_actors).all
    render template: 'actors/index'
  end

  # bullet:NG ならばaccociationに沿ったincludesを書いてやろうと意気込んだものの、movies に値が
  # セットされていないので n+1 が発生し bullet:NG
  def index7
    @actors = Actor.includes(movie_actors: :movie).all
    render template: 'actors/index'
  end

  # bullet:OK cacheは走るものの、良さげ。あとはソートのみ
  def index8
    @actors = Actor.includes(movie_actors: :movie).includes(:movies).all
    render template: 'actors/index'
  end

  # bullet:OK ただし、preloadする時に `movies.id` でソートが走ってしまい、500エラーに
  def index9
    @actors = Actor.includes(movie_actors: :movie).includes(:movies).all.order('actors.id, movies.id')
    render template: 'actors/index'
  end

  # bullet:OK ただし、movie_actorsとmoviesが２度づつ left outer joinされるこれまでで最悪の結果に…
  def index10
    @actors = Actor.eager_load(:movies).includes(movie_actors: :movie).all.order('actors.id, movies.id')
    render template: 'actors/index'
  end


  # bullet:NG ただし index4 の left join版でこれで正解でもいいんじゃないのかな…
  def index11
    @actors = Actor.eager_load(:movies).all.order('actors.id, movies.id')
    render template: 'actors/index'
  end

  # bullet:OK なんでOK何だ？ n+1 的なSQLログがめっちゃ出るのに…
  def index12
    @actors = Actor.joins(movie_actors: :movie).includes(:movies).all.order("actors.id, movies.id")
    render template: 'actors/index'
  end
      
  # ... もう思い浮かばない…  

end

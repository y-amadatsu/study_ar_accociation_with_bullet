Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  (1..20).each do |i|
    get "actors/index#{i}", to: "actors#index#{i}"
  end
end

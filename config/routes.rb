Conductor::Engine.routes.draw do

  scope '/conductor' do

  	resources :pages do
      get 'preview'
      get 'new_child'
      post 'savesort', on: :collection
    end

    resources :articles do
      post ':id/tag' => :tag, on: :collection, :as => 'tag'
      post ':id/untag/:tag_id' => :untag, on: :collection, :as => 'untag'
    end

    resources :tags

  end

  get 'blog' => 'articles#home'
  match "blog/:year/:month/:slug" => "articles#show", :constraints => { :year => /\d{4}/, :month => /[01]?\d/ }

  get '(:parent)/:slug' => 'pages#show'

	root :to => 'pages#show'

end

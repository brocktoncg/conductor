Conductor::Engine.routes.draw do

	resource :pages

	root :to => "pages#index"

end

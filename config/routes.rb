Spelling::Application.routes.draw do

#  get "confirmations/show"

  devise_for :users,
    :controllers => {
      :registrations => "registrations",
      :confirmations => "confirmations"
      }

  devise_scope :user do
    put "/confirm" => "confirmations#confirm"
  end

  get "progress_review/cuadrant"

  get "welcome/index"
	get "welcome/promo"
  get "welcome/for_teachers"
  get "welcome/attribution"


#	get "application/redirector"

  post "list_stats/reset"

	# The specific routes have to come before the "resources" line, or they'll
	# get matched as /list_item/:id

	resources :list_items, :except => %w(index create new show update destroy edit) do
		member do
			get "practice"
		end
		member { get "practice_with_letters" }
		member do
			get "test"
		end
		member do
			post "check"
		end
		member { post "check_with_letters" }
	end

	resources :word_lists do
		member do
			post "assign_many"
		end
		member do
			delete "unassign_many"
		end
		member do
			get "maintain_assignments"
		end
		member do
			get "list_complete"
		end
		member do
			get "assign"
		end
		member do
			get "study"
		end
		member do
			get "practice"
		end
		member do
			get "review_assignment"
		end
		member do
			get "cuadrant"
		end
	end

	namespace :admin do
	  resources :users
	end

	resources :students, :except => %w(index create new update destroy edit)
	resources :parents, :except => %w(index create new update destroy edit)
	resources :users, :only => %w(show update edit) do
		member { get "delegate_parent" }
		member { get "invite" }
		member { post "send_invitation" }
		member { post "create_delegate_parent" }
		member { post "send_invitation" }
	end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

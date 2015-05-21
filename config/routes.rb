Haushalt::Application.routes.draw do
  root :to => 'transactions#index'
  resources :transactions, :only => [:index, :show, :edit, :update] do
    collection do
      get 'daily_min'
      get 'monthly'
      get 'monthly_withdrawal'
      get 'overall'
    end
  end
end

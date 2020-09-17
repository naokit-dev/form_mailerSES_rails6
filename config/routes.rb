Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get  '/new', to: 'static_pages#new', as: 'new'
  post '/confirm', to: 'static_pages#cofirm', as: 'confirm'
  post '/send', to: 'static_pages#send_mail', as: 'send'
  post '/new', to: 'static_pages#back', as: 'back'
  get  '/complete', to: 'static_pages#complete', as: 'complete'

end

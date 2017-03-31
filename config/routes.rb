Rails.application.routes.draw do
    get "/usuario", to: "users#index"
    put "/usuario",  to: "users#create"
    get "/usuario/:id", to: "users#show"
    post  "/usuario/:id",  to: "users#update"
    delete "/usuario/:id",  to: "users#destroy"

end

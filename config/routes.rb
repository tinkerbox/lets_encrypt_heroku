Rails.application.routes.draw do
  get '/.well-known/acme-challenge/:id' => 'challenges#show', as: :challenges
end

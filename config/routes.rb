LetsEncryptHeroku::ChallengeEngine.routes.draw do
  get 'acme-challenge/:id' => 'challenges#show', as: :challenges
end

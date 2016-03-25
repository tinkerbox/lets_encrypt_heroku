module LetsEncryptHeroku
  class ChallengesController < ::ApplicationController
    def show
      @challenge = ChallengeRecord.find_by(params[:id])
      render text: "#{params[:id]}.#{@challenge.token}"
    end
  end
end

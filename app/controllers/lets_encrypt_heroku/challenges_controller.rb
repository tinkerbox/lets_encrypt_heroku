module LetsEncryptHeroku
  class ChallengesController < ::ApplicationController

    skip_before_action :require_login

    def show
      @challenge = ChallengeRecord.find_by_token(params[:id])
      render inline: @challenge.file_content, type: @challenge.content_type
    end

  end
end

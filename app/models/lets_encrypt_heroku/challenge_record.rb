module LetsEncryptHeroku
  class ChallengeRecord < ActiveRecord::Base
    attr_accessible :token, :filename, :file_content, :content_type
  end
end

class CreateChallengeRecordsTable < ActiveRecord::Migration

  def self.up
    create_table :lets_encrypt_heroku_challenge_records do |t|
      t.string :token
      t.string :filename
      t.string :file_content
      t.string :content_type
      t.timestamps
    end
  end

  def self.down
    drop_table :lets_encrypt_heroku_challenge_records
  end

end

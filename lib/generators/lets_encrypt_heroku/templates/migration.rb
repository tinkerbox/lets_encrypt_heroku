class CreateChallengeRecords < ActiveRecord::Migration

  def self.up
    create_table :challenge_records do |t|
      t.string :token
      t.string :filename
      t.string :file_content
      t.string :content_type
      t.timestamps
    end
  end

  def self.down
    drrop_table :challenge_records
  end

end

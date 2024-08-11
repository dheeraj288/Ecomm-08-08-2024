class CreateEmailOtps < ActiveRecord::Migration[7.1]
  def change
    create_table :email_otps do |t|
      t.string :email
      t.datetime :valid_until
      t.boolean :activated

      t.timestamps
    end
  end
end

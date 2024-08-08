class CreateSmsOtps < ActiveRecord::Migration[7.1]
  def change
    create_table :sms_otps do |t|
      t.string :full_phone_number
      t.datetime :valid_until
      t.boolean :activated

      t.timestamps
    end
  end
end

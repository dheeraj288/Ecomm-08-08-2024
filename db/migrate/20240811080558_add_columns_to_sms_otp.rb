class AddColumnsToSmsOtp < ActiveRecord::Migration[7.1]
  def change
    add_reference :sms_otps, :account, null: false, foreign_key: true
  end
end

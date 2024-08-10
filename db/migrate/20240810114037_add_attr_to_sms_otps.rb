class AddAttrToSmsOtps < ActiveRecord::Migration[7.1]
  def change
    add_column :sms_otps, :otp, :string
  end
end

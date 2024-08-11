class AddAttrToEmailOtps < ActiveRecord::Migration[7.1]
  def change
    add_column :email_otps, :otp, :string
  end
end

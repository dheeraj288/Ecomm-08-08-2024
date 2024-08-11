class AddColumnsToEmailOtp < ActiveRecord::Migration[7.1]
  def change
    add_reference :email_otps, :account, null: false, foreign_key: true
  end
end

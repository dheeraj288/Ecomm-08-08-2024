class AddAttrToEmailOtps < ActiveRecord::Migration[7.1]
  def change
    add_column :email_opts, :otp, :string
  end
end

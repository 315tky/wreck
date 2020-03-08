class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :login_status
      t.string :eve_sso_token

      t.timestamps
    end
  end
end

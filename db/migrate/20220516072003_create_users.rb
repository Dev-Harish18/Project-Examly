class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :institution
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :roll_no

      t.timestamps
    end
  end
end

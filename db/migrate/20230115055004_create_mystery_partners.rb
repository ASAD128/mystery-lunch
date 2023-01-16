class CreateMysteryPartners < ActiveRecord::Migration[6.1]
  def change
    create_table :mystery_partners do |t|
      t.integer :employee1_id,              null: false
      t.integer :employee2_id,              null: false
      t.integer :employee3_id

      ## Adding employees department IDs as well to retrieve the data faster when applied the department filter

      t.integer :employee1_department_id,   null: false
      t.integer :employee2_department_id,   null: false
      t.integer :employee3_department_id

      t.timestamps
    end

    add_index :mystery_partners, :employee1_id
    add_index :mystery_partners, :employee2_id
    add_index :mystery_partners, :employee3_id
    add_index :mystery_partners, :employee1_department_id
    add_index :mystery_partners, :employee2_department_id
    add_index :mystery_partners, :employee3_department_id
  end
end

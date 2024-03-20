class CreateFaculties < ActiveRecord::Migration[7.1]
  def change
    create_table :faculties do |t|
      t.string :name, unique: true

      t.timestamps
    end
  end
end

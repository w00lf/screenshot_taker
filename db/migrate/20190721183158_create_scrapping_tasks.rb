class CreateScrappingTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :scrapping_tasks do |t|
      t.uuid :uuid
      t.string :name

      t.timestamps
    end
  end
end

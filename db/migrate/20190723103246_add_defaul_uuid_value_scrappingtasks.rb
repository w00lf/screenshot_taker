class AddDefaulUuidValueScrappingtasks < ActiveRecord::Migration[5.2]
  def change
    change_column :scrapping_tasks, :uuid, :uuid, default: 'uuid_generate_v4()', index: true
  end
end

class RenameColumnKillMailItemTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :killmail_items, :flag, :flag_id
  end
end

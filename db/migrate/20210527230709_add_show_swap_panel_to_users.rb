class AddShowSwapPanelToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :show_swap_panel, :boolean, default: true
  end
end

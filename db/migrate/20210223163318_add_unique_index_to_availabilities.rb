class AddUniqueIndexToAvailabilities < ActiveRecord::Migration[6.0]
  def change
    # creating a unique multi-column index involving date is not a feature
    # supported by Rails 6.0
    execute("create unique index index_availabilities_on_motel_id_and_swap_id_and_date ON availabilities(motel_id, swap_id, date);")
  end
end

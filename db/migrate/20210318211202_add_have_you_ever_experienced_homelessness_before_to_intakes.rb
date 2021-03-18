class AddHaveYouEverExperiencedHomelessnessBeforeToIntakes < ActiveRecord::Migration[6.0]
  def change
    add_column :intakes, :have_you_ever_experienced_homelessness_before, :boolean
  end
end

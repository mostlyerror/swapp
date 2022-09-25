# == Schema Information
# Schema version: 20220924214711
#
# Table name: clients
#
#  id                       :bigint           not null, primary key
#  banned                   :boolean          default(FALSE)
#  date_of_birth            :date
#  email                    :string
#  ethnicity                :string
#  family_members           :jsonb
#  first_name               :string           not null
#  force_intake             :boolean          default(FALSE)
#  gender                   :string
#  last_name                :string           not null
#  log_data                 :jsonb
#  phone_number             :string
#  race                     :jsonb
#  veteran                  :boolean
#  veteran_discharge_status :string
#  veteran_military_branch  :string
#  veteran_separation_year  :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
module ClientsHelper
  def formatted_date(dt)
    dt.to_date.to_formatted_s(:date_of_birth)
  end

  def button_class(disabled)
    disabled ?
      "bg-gray-100 hover:none text-gray-500 text-center px-4 md:px-8 py-1 md:py-2 rounded-lg shadow cursor-not-allowed" :
      "bg-indigo-600 hover:bg-indigo-700 text-white text-center px-4 md:px-8 py-1 md:py-2 rounded-lg shadow"
  end
end

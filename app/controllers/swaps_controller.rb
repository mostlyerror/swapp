# == Schema Information
# Schema version: 20220924214711
#
# Table name: swaps
#
#  id           :bigint           not null, primary key
#  end_date     :date
#  intake_dates :date             default([]), is an Array
#  log_data     :jsonb
#  start_date   :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class SwapsController < ApplicationController
  def index
  end
end

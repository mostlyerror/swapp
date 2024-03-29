class RoomSupply
  # how many rooms did each hotel say they had available today?
  def self.latest_vacancies(swap)
    avs =
      swap.availabilities.reload.where(
        date: ([swap.start_date, swap.intake_dates.first].min)..swap.end_date,
        created_at: Date.current.all_day,
      )
    Hotel
      .active
      .pluck(:id)
      .reduce({}) do |memo, hotel_id|
        av = avs.find { |av| av.hotel_id == hotel_id }
        vacancy = av.present? ? av.vacant : 0
        memo.merge({ hotel_id => vacancy })
      end
  end

  # how many vouchers per hotel were issued today?
  def self.vouchers_issued_today(swap)
    hotel_ids = Hotel.active.pluck(:id)
    hotels = hotel_ids.zip(Array.new(hotel_ids.size, 0)).to_h
    vouchers =
      swap
        .vouchers
        .where(created_at: Date.current.all_day)
        .group(:hotel_id)
        .active
        .count
    hotels.merge(vouchers)
  end

  # vacancies - vouchers issued
  def self.vouchers_remaining_today(swap)
    vac = latest_vacancies(swap)
    vou = vouchers_issued_today(swap)
    vac.merge(vou) { |_k, vacancies, vouchers| vacancies - vouchers }
  end

  def self.num_vouchers_remaining_today(swap)
    vouchers_remaining_today(swap).values.reduce(:+).to_i
  end

  def self.by_hotel(swap)
    supply =
      Hotel
        .active
        .reduce({}) do |memo, hotel|
          dates =
            swap
              .intake_dates
              .reduce({}) do |dates, day|
                dates.merge({ day => { vacant: nil, issued: nil } })
              end
          memo.merge({ hotel.id => dates })
        end

    vouchers =
      swap
        .vouchers
        .where(created_at: Date.current.all_day)
        .group(:hotel_id)
        .active
        .count

    swap
      .availabilities
      .where(
        date: ([swap.start_date, swap.intake_dates.first].min)..swap.end_date,
        created_at: Date.current.all_day,
      )
      .each_with_object(supply) do |av, supply|
        supply[av.hotel_id][av.date][:vacant] = av.vacant
        supply[av.hotel_id][Date.current][:issued] = vouchers[av.hotel_id].to_i
      end
  end
end

class RoomSupply
  # how many rooms did each motel say they had available today?
  def self.latest_vacancies(swap)
    avs = swap.availabilities.reload
    Motel.pluck(:id).reduce({}) do |memo, motel_id|
      av = avs.select { |av| av.motel_id == motel_id }.first
      vacancy = av.present? ? av.vacant : 0
      memo.merge(Hash[motel_id, vacancy])
    end
  end

  # how many vouchers per motel were issued today?
  def self.vouchers_issued_today(swap)
    motel_ids = Motel.pluck(:id)
    motels = motel_ids.zip(Array.new(motel_ids.size, 0)).to_h
    vouchers = swap.vouchers
      .where(created_at: Date.current.beginning_of_day..Date.current.end_of_day)
      .group(:motel_id)
      .count
    motels.merge(vouchers)
  end

  # vacancies - vouchers issued
  def self.vouchers_remaining_today(swap)
    vac = self.latest_vacancies(swap)
    vou = self.vouchers_issued_today(swap)
    vac.merge(vou) { |_k, vacancies, vouchers| vacancies - vouchers }
  end

  def self.by_motel(swap)
    supply = Motel.all.reduce({}) do |memo, motel| 
      dates = swap.intake_period.to_a.reduce({}) do |dates, day|
        dates.merge(Hash[day, {vacant: nil, issued: nil}])
      end
      memo.merge(Hash[motel.id, dates])
    end

    vouchers = swap.vouchers
      .where(created_at: Date.current.beginning_of_day..Date.current.end_of_day)
      .group(:motel_id)
      .count

    swap.availabilities
      .where(created_at: Date.current.beginning_of_day..Date.current.end_of_day)
      .each_with_object(supply) do |av, supply|
        supply[av.motel_id][av.date][:vacant] = av.vacant
        supply[av.motel_id][Date.current][:issued] = vouchers[av.motel_id].to_i
      end
  end
end

class RoomSupply
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
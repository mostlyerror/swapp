class RoomSupply
  def self.by_motel(swap)
    intake_days = swap.intake_period.to_a

    dates = intake_days.zip(
      Array.new(intake_days.size) { {vacant: nil, issued: nil}}
    ).to_h

    supply = Motel.all.reduce({}) do |memo, motel| 
        memo.merge(Hash[motel, dates.clone])
      end

    vouchers = swap.vouchers
      .where("date(created_at) = ?", Date.current)
      .group(:motel_id)
      .count

    swap.availabilities
      .where("date(created_at) = ?", Date.current)
      .each_with_object(supply) do |av, supply|
        supply[av.motel][av.date][:vacant] = av.vacant
        supply[av.motel][av.date][:issued] = vouchers[av.motel]
      end
  end
end
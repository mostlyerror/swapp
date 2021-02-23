class RoomAvailability
  def self.by_motel(swap)
    swap.availabilities.reduce({}) do |memo, av|
      memo.merge Hash[av.motel_id, Hash[av.date, av.rooms]]
    end
  end
end
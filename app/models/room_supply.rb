class RoomSupply
  # builds a hash that provides data to the per motel per day supply tables
  # { motel => { date => rooms } }
  def self.by_motel(swap)
    motels = Motel.all.to_a
    days = swap.stay_period.zip(Array.new(swap.stay_period.to_a.size, nil)).to_h

    rooms = motels.reduce({}) do |memo, motel|
      memo.merge(Hash[motel, days.clone])
    end

    swap.availabilities.each_with_object(rooms) do |av, rooms|
      rooms[av.motel][av.date] = av.rooms
    end
  end
end
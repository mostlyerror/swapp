# frozen_string_literal: true

class AddHotelUsers < ActiveRecord::Migration[6.0]
  def up
    columns = %w[first_name last_name email]
    hotel = Hotel.find_or_create_by(name: "HomeTowne Studios (Thornton)")
    [
      %w[Paula Hudson Paulina.Hudson@whgextstay.com],
      %w[Shalimar Narvaez 3510-GM@whgextstay.com],
      %w[Reed Martini reed.martini@whgextstay.com],
      %w[Erica Holmes erica.holmes@whgextstay.com]
    ].each do |tuple|
      attrs = columns.zip(tuple).to_h
      password = attrs['first_name'].first.downcase + attrs['last_name'][0...3].downcase + '2022'

      if user = User.find_by(email: attrs["email"])
        HotelUser.create!( user: user, hotel: hotel)
      else
        attrs.merge! password: password, password_confirmation: password, hotel_user: true
        user = User.create! attrs
        HotelUser.create!( user: user, hotel: hotel)
      end
    end

    hotel = Hotel.find_or_create_by(name: "HomeTowne Studios (Aurora)")
    [
      # %w[Paula Hudson Paulina.Hudson@whgextstay.com],
      # ['Keesha', '', '3511-GM@whgextstay.com'],
      %w[Reed Martini reed.martini@whgextstay.com],
      %w[Erica Holmes erica.holmes@whgextstay.com]
    ].each do |tuple|
      attrs = columns.zip(tuple).to_h
      password = attrs['first_name'].first.downcase + attrs['last_name'][0...3].downcase + '2022'

      if user = User.find_by(email: attrs["email"])
        HotelUser.create!( user: user, hotel: hotel)
      else
        attrs.merge! password: password, password_confirmation: password, hotel_user: true
        user = User.create! attrs
        HotelUser.create!( user: user, hotel: hotel)
      end
    end
    
    hotel = Hotel.find_or_create_by(name: "Triangle T Motel (Commerce City)")
    [
      %w[Hyun Song Song.ink@yahoo.com]
    ].each do |tuple|
      attrs = columns.zip(tuple).to_h
      password = attrs['first_name'].first.downcase + attrs['last_name'][0...3].downcase + '2022'

      if user = User.find_by(email: attrs["email"])
        HotelUser.create!( user: user, hotel: hotel)
      else
        attrs.merge! password: password, password_confirmation: password, hotel_user: true
        user = User.create! attrs
        HotelUser.create!( user: user, hotel: hotel)
      end
    end

    hotel = Hotel.find_or_create_by(name: "Penn Motel (Commerce City)")
    [
      %w[Eva Song pennmotel@gmail.com]
    ].each do |tuple|
      attrs = columns.zip(tuple).to_h
      password = attrs['first_name'].first.downcase + attrs['last_name'][0...3].downcase + '2022'

      if user = User.find_by(email: attrs["email"])
        HotelUser.create!( user: user, hotel: hotel)
      else
        attrs.merge! password: password, password_confirmation: password, hotel_user: true
        user = User.create! attrs
        HotelUser.create!( user: user, hotel: hotel)
      end
    end
    
    hotel = Hotel.find_or_create_by(name: "Quality Inn (Brighton)")
    [
      %w[Front Desk qualityinnbrighton@gmail.com]
    ].each do |tuple|
      attrs = columns.zip(tuple).to_h
      password = attrs['first_name'].first.downcase + attrs['last_name'][0...3].downcase + '2022'

      if user = User.find_by(email: attrs["email"])
        HotelUser.create!( user: user, hotel: hotel)
      else
        attrs.merge! password: password, password_confirmation: password, hotel_user: true
        user = User.create! attrs
        HotelUser.create!( user: user, hotel: hotel)
      end
    end

    hotel = Hotel.find_or_create_by(name: "Quality Inn (Westminster)")
    [
      %w[Heidi Hall gm.co734@choicehotels.com]
    ].each do |tuple|
      attrs = columns.zip(tuple).to_h
      password = attrs['first_name'].first.downcase + attrs['last_name'][0...3].downcase + '2022'

      if user = User.find_by(email: attrs["email"])
        HotelUser.create!( user: user, hotel: hotel)
      else
        attrs.merge! password: password, password_confirmation: password, hotel_user: true
        user = User.create! attrs
        HotelUser.create!( user: user, hotel: hotel)
      end
    end

    hotel = Hotel.find_or_create_by(name: "Suburban Extended Stay Westminster Denver North")
    [
      %w[Jennifer Hudson Westminster.GM@hotelmc.net],
      %w[Front Desk westminister@hotelmc.net]
    ].each do |tuple|
      attrs = columns.zip(tuple).to_h
      password = attrs['first_name'].first.downcase + attrs['last_name'][0...3].downcase + '2022'

      if user = User.find_by(email: attrs["email"])
        HotelUser.create!( user: user, hotel: hotel)
      else
        attrs.merge! password: password, password_confirmation: password, hotel_user: true
        user = User.create! attrs
        HotelUser.create!( user: user, hotel: hotel)
      end
    end
  end

  def down
  end
end



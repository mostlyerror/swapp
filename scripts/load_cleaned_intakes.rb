reload!
filename = Rails.root.join("intakes.csv")

ActiveRecord::Base.transaction do
  Intake.destroy_all
  ShortIntake.destroy_all

  swaps_start = Swap.count
  clients_start = Client.count
  intakes_start = Intake.count
  short_intakes_start = ShortIntake.count
  vouchers_start = Voucher.count
  puts "Swap start: #{swaps_start}, end: #{Swap.count}"
  puts "Swap start: #{clients_start}, end: #{Client.count}"
  puts "Swap start: #{intakes_start}, end: #{Intake.count}"
  puts "Swap start: #{short_intakes_start}, end: #{ShortIntake.count}"
  puts "Swap start: #{vouchers_start}, end: #{Voucher.count}"


  opts = {
    headers: true,
    header_converters: ->(h) { h&.strip },
    converters: ->(f) { f&.strip }
  }
  CSV.foreach(filename, opts) do |row|
    voucher = Voucher
      .includes(:client, :motel, :user)
      .find_by(number: row['voucher_number'])

    if voucher
      voucher.num_adults_in_household = row['adults_ct']
      voucher.num_children_in_household = row['children_ct']
      if !voucher.save(validate: false)
        ap row
        ap voucher.errors.messages
        raise :fail
      end

      client = voucher.client
      user = voucher.user

      intake_attrs = {
        client: client,
        user: user,
        homelessness_first_time: 
          row['firsttime_hl'],
        how_long_this_time: 
          row['duration_hl'],
        episodes_last_three_years_fewer_than_four_times: 
          row['sheltersstreets_3yr_ct'],
        total_how_long_shelters_or_streets: 
          row['duration_sheltersstreets'],
        are_you_working: 
          ActiveRecord::Type::Boolean.new.cast(row['working']),
        armed_forces:
          ActiveRecord::Type::Boolean.new.cast(row['armedforces']),
        active_duty:
          ActiveRecord::Type::Boolean.new.cast(row['ntlguard_reservist']),
        substance_abuse:
          ActiveRecord::Type::Boolean.new.cast(row['substance_abuse']),
        chronic_health_condition:
          ActiveRecord::Type::Boolean.new.cast(row['chronic_health']),
        mental_health_disability:
          ActiveRecord::Type::Boolean.new.cast(row['mental_health']),
        physical_disability:
          ActiveRecord::Type::Boolean.new.cast(row['physical_disab']),
        developmental_disability:
          ActiveRecord::Type::Boolean.new.cast(row['developmtl_disab']),
        fleeing_domestic_violence:
          ActiveRecord::Type::Boolean.new.cast(row['dom_viol']),
        last_permanent_residence_county:
          ActiveRecord::Type::Boolean.new.cast(row['lastperm_county'])
      }

      intake = Intake.create(intake_attrs)
      if !intake.persisted?
        ap row
        ap intake.errors.messages
        raise :fail
      end

      short_intake_attrs = {
        client: client,
        user: user,
        where_did_you_sleep_last_night:
          [row['last_night']],
        what_city_did_you_sleep_in_last_night:
          nil,
        why_not_shelter:
          row['reason_noshelter'],
        bus_pass:
          ActiveRecord::Type::Boolean.new.cast(row['buspass']),
        king_soopers_card:
          ActiveRecord::Type::Boolean.new.cast(row['kingsoopers']),
        household_composition_changed:
          false,
        family_members:
          {},
      }

      short_intake = ShortIntake.create(short_intake_attrs)
      if !short_intake.persisted?
        ap row
        ap short_intake.errors.messages
        raise :fail
      end
    end
  end
end

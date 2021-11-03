namespace :data do
  desc "write hotels csv to filesystem" 
  task export_hotels_csv: :environment do
    ts = Time.now.strftime("%Y%m%dT%H%M")
    file_name = "hotels_#{ts}.csv"
    File.write(file_name, Hotel.to_csv)
  end

  desc "upsert hotels from csv, based on ID field\n\nWarning: If ID is present,
  this WILL overwrite all columns for hotel records."
  task :import_hotels_csv, [:file_name] => :environment do |t, args|
    if !args.key?(:file_name)
      puts "Usage: $ rails data:import_hotels_csv[file_name.csv]"
      raise ArgumentError.new("must provide file_name arg") 
    end

    if !File.exist?(args[:file_name])
      raise ArgumentError.new("file does not exist")
    end

    csv_str = File.read(args[:file_name])
    csv = CSV.parse(csv_str, headers: true)

    ActiveRecord::Base.transaction do 
      csv.each do |row|
        row["address"] = JSON.parse(row["address"]) if row["address"].present?
        row.delete(:created_at)
        row.delete(:updated_at)

        if id = row.delete("id").last
          Hotel.find(id).update!(row.to_h)
        else
          Hotel.create!(row.to_h)
        end
      end
    end
  end
end

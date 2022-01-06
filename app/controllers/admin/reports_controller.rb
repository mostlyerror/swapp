class Admin::ReportsController < Admin::BaseController
  def vouchers
    remove_attrs = %w[id created_at updated_at]

    csv = CSV.generate(headers: true) do |csv|
      csv << %w[
        voucher_number
        voucher_check_in
        voucher_check_out
        voucher_issued_date
        voucher_issued_time
        voucher_issued_by
        voucher_voided_at
        voucher_voided_by
        voucher_hotel_name
        client_first_name
        client_last_name
        client_date_of_birth
        client_gender
        client_phone_number
        client_email
        client_race
        client_ethnicity
        voucher_guests
      ]

      Voucher.includes(:issuer, :voided_by, :hotel, :client)
        .order(id: :asc)
        .find_each do |voucher|
        csv << [
          voucher.number,
          voucher.check_in,
          voucher.check_out,
          voucher.created_at.to_date.to_s,
          voucher.created_at.strftime("%r"),
          voucher.issuer&.name,
          voucher.voided_at,
          voucher.voided_by&.name,
          voucher.hotel&.name,
          voucher.client&.first_name,
          voucher.client&.last_name,
          voucher.client&.date_of_birth,
          voucher.client&.gender,
          voucher.client&.phone_number,
          voucher.client&.email,
          voucher.client&.race&.join(","),
          voucher.client&.ethnicity,
          format_guests(voucher.guests)
        ]
      end
    end

    respond_to do |format|
      format.csv { send_data csv, filename: "vouchers-#{Time.zone.now.iso8601}.csv" }
    end
  end

  def format_guests(guests)
    guests.map do |guest|
      "#{guest.name} - #{guest.date_of_birth}"
    end.join(", ")
  end
end

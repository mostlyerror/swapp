class Admin::ReportsController < Admin::BaseController
  def swap
    remove_attrs = %w( id created_at updated_at )

    csv = CSV.generate(headers: true) do |csv|
      csv << %w(
        voucher_number
        voucher_check_in
        voucher_check_out
        voucher_motel_name
        client_first_name
        client_last_name
        client_date_of_birth
        client_gender
        client_phone_number
        client_email
        client_race
        client_ethnicity
      )

      Voucher.includes(:client, :motel)
        .order(id: :asc)
        .find_each do |voucher|
        csv << [
          voucher.number,
          voucher.check_in,
          voucher.check_out,
          voucher.motel.name,
          voucher.client.first_name,
          voucher.client.last_name,
          voucher.client.date_of_birth,
          voucher.client.gender,
          voucher.client.phone_number,
          voucher.client.email,
          voucher.client.race&.join(","),
          voucher.client.ethnicity,
        ]
      end
    end

    respond_to do |format|
      format.csv { send_data csv, filename: "vouchers-#{Time.zone.now.iso8601}.csv" }
    end
  end
end
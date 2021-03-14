class Admin::ReportsController < Admin::BaseController
  def swap
    csv = CSV.generate(headers: true) do |csv|
      csv << Voucher.attribute_names
      Voucher.all.each do |record|
        csv << record.attributes.values
      end
    end

    respond_to do |format|
      format.csv { send_data csv, filename: "vouchers-#{Date.today}.csv" }
    end
  end
end

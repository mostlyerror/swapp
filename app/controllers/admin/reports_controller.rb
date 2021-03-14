class Admin::ReportsController < Admin::BaseController
  def swap
    remove_attrs = %w( id created_at updated_at )

    csv = CSV.generate(headers: true) do |csv|
      client_attrs = Client.attribute_names.reject { |attr| attr.in?(remove_attrs)  }
      voucher_attrs = Voucher.attribute_names.reject { |attr| attr.in?(remove_attrs)  }
      csv << client_attrs.concat(voucher_attrs)

      Voucher.all.each do |voucher|
        voucher_attrs = voucher.attributes.except(*remove_attrs).values
        client_attrs = voucher.client.attributes.except(*remove_attrs).values
        csv << client_attrs.concat(voucher_attrs)
      end
    end

    respond_to do |format|
      format.csv { send_data csv, filename: "vouchers-#{Date.today}.csv" }
    end
  end
end

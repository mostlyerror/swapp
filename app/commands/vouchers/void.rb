module Vouchers
  class Void < BaseCommand
    object :voucher
    object :user

    def execute
      ActiveRecord::Base.transaction do
        void_voucher
      end
    end

    private

    def void_voucher
      # can't void a voucher already voided
      return if voucher.voided?

      voucher.void!(user)

      # return if !home_installation_order
      # Orders::Cancel.run(order_id: home_installation_order.id)
      # home_installation_order.update(
      #   notes:
      #     'This order was cancelled by supply opperations. ' +
      #       home_installation_order.notes.to_s,
      # )
    end
  end
end

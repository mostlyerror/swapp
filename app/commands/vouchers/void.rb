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
      return if voucher.voided?

      voucher.void!(user)
    end
  end
end

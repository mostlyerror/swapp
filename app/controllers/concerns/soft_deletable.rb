module SoftDeletable
  extend ActiveSupport::Concern

  included do
    acts_as_paranoid
    before_destroy :update_timestamps
  end

  def update_timestamps
    update updated_at: Time.current
  end
end

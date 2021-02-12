class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :incident_reports, as: :reporter

  def to_s
    "#{first_name}, #{last_name} (#{email})"
  end
end

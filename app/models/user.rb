class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :incident_reports, as: :reporter
  has_many :intakes

  def to_s
    "#{name} (#{email})"
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end

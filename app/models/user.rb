# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  timezone               :string
#  username               :citext
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_picture
  has_many :calendars, foreign_key: "owner_id", dependent: :destroy
  has_many :events, through: :calendars
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships

  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :timezone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name), message: "%{value} is not a valid timezone" }

  after_create :create_default_calendar

  private

  def create_default_calendar
    self.calendars.create(title: "#{self.name.capitalize}'s Calendar")
  end
end

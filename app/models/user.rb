class User < ApplicationRecord
  extend FriendlyId
  friendly_id :handle, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :definitions

  def handle
    super || handle_from_email
  end

  def handle_from_email
    "#{email.split('@').first}_#{Digest::MD5.hexdigest(email)[0..5]}"
  end
end

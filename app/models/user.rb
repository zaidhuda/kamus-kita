class User < ApplicationRecord
  extend FriendlyId
  friendly_id :handle, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :definitions
  has_many :votes
  validates_presence_of :handle
  validates_length_of :handle, minimum: 4, maximum: 32

  def self.create_guest_user
    guest = self.new(
      email: "#{SecureRandom.uuid}@fake.email",
      password: SecureRandom.hex,
      guest: true)
    guest.handle = "Guest #{Digest::MD5.hexdigest(guest.email)[0..5].humanize}"
    guest.save
    guest
  end

  def handle
    super || handle_from_email
  end

  def handle_from_email
    "User #{Digest::MD5.hexdigest(email)[0..5]}"
  end

  def deleted_handle_from_email
    "Deleted #{handle_from_email}"
  end

  def points
    votes = definitions.votes
    likes = votes.likes
    dislikes = votes.dislikes
    self.votes.significant.ids.size + definitions.ids.size + votes.likes - [votes.dislikes, [votes.likes, 1].max*2].min
  end

  def should_generate_new_friendly_id?
    true
  end
end

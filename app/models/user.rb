class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :groups
  mount_uploader :avatar
  scope :online, -> { where(online: true) }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  # def self.find_for_database_authentication(conditions={})
  #   self.where("name = ?", conditions[:email]).limit(1).first ||
  #   self.where("email = ?", conditions[:email]).limit(1).first
  # end

	def avatar_or_gravatar
		self.avatar? ? self.avatar : self.gravatar
	end

	def gravatar
		"https://secure.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}.png?s=64"
	end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :groups
  mount_uploader :avatar
  scope :online, -> { where('last_requested_at >= ?', 5.minutes.ago) }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: {
    :case_sensitive => false
  }

  # def self.find_for_database_authentication(conditions={})
  #   self.where("name = ?", conditions[:email]).limit(1).first ||
  #   self.where("email = ?", conditions[:email]).limit(1).first
  # end

	def avatar_or_gravatar
		self.avatar? ? self.avatar : self.gravatar
	end

  def online?
    l = last_requested_at
    l && l >= 5.minutes.ago
  end

  def last_requested_at
    Rails.cache.read("lastrequest:#{id}") #|| super
  end

  def last_requested_at=(time)
    #super
    Rails.cache.write("lastrequest:#{id}", time)
  end

	def gravatar
		"https://secure.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}.png?s=64&d=identicon&r=PG&f=1"
	end

  def after_database_authentication
    self.last_requested_at = Time.now
    save
  end

  def self.find_for_database_authentication(warden_conditions)
     conditions = warden_conditions.dup
     if login = conditions.delete(:email)
       where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
       # where(conditions).where(name: login).first || where(conditions).where(email: login).first
     else
       where(conditions).first
     end
   end
end

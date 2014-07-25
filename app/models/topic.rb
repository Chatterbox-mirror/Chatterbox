class Topic < ActiveRecord::Base
  belongs_to :group
  has_many :comments
  validates :title, presence: true
  belongs_to :owner, class_name: 'User'
  scope :closed, -> { where status: 'closed'}
  scope :open, -> { where status: 'open' }
  scope :by_status, -> (s) { where status: s }

  def close!
    self.status = 'closed'
  end
end

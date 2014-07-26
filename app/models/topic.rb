class Topic < ActiveRecord::Base
  belongs_to :group
  has_many :comments

  validates :title, :group_id, presence: true

  belongs_to :owner, class_name: 'User'
  scope :closed, -> { where status: 'closed'}
  scope :open, -> { where status: 'open' }
  scope :by_status, -> (s) { where status: s }

  def close!
    self.status = 'closed'
  end

  def closed?
    status == 'closed'
  end
end

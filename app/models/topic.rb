class Topic < ActiveRecord::Base
  belongs_to :group
  has_many :comments
  validates :title, presence: true
  belongs_to :owner, class_name: 'User'
end

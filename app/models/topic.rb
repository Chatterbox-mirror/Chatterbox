class Topic < ActiveRecord::Base
  belongs_to :group
  has_many :comments
  validates :title, presence: true
end

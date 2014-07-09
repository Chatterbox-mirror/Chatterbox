class Group < ActiveRecord::Base
  has_and_belongs_to_many :members, class_name: 'User'
  has_many :topics
  has_many :comments, through: :topics

  mount_uploader :icon, IconUploader

  def member_count
    0
  end

  def description
    ''
  end
end

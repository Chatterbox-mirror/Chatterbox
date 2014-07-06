class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  scope :after, -> (start) { where("id > ?", start) }
  scope :before, -> (e) { where("id < ?", e) }

end

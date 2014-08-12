class Picture < Comment
  mount_uploader :picture, PictureUploader
  validates :content, presence: false
end

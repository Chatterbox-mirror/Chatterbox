class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :actor, class_name: 'User'
  serialize :content, Hash
  def translate data={}
    data.merge! as_json
    data[:actor] = I18n.t "notifications.you" if actor == user
    I18n.t "notifications.#{self.class.name.demodulize.underscore}", data
  end
end

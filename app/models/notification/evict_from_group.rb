class Notification::EvictFromGroup < Notification
  def operator
    User.where(id: content[:operator_id]).first
  end

  def translate data={}
    data[:operator] = operator
    super(data)
  end
end

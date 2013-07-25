class ReceivedInvitationsSerializer < ActiveModel::Serializer
  attributes :id, :sender_first_name, :sender_last_name, :memory_box_id, :memory_box_title, :status, :created_at

  def sender_first_name
  	object.sender.first_name
  end

  def sender_last_name
  	object.sender.last_name
  end

  def memory_box_id
  	object.memory_box.id
  end

  def memory_box_title
  	object.memory_box.title
  end

  def memory_box_preview_image
  	object.memory_box.preview_image
  end
end
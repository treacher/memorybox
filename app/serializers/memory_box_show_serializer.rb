class MemoryBoxShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :admin, :owner, :invited_users

  def admin
  	current_user.admin?(object.id)
  end

  def owner
    if owner = object.members.where(role: "Owner").first
    	owner = owner.user
    	return "#{owner.first_name} #{owner.last_name}"
    end
  end

  def invited_users
  	return [] unless admin
  	object.members.map do |member|
  		next if member.role == "Owner"
  		"#{member.user.first_name} #{member.user.last_name}"
  	end.reject { |u| !u.present? }
  end
end
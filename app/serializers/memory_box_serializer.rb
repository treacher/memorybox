class MemoryBoxSerializer < ActiveModel::Serializer
  attributes :id, :title, :preview_image, :owner_name

  def owner_name
  	"#{object.owner.try(:first_name)} #{object.owner.try(:last_name)}"
  end
end

class MemoryBox < ActiveRecord::Base
  acts_as_paranoid column: 'deleted', column_type: 'boolean'
  
  validates :title, presence: true

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :entries, dependent: :destroy
  has_many :invitations, dependent: :destroy

  def create_entry!(attributes)
    self.entries.create(attributes)
  end

  def find_entry(entry_id)
    self.entries.find(entry_id)
  end

  def delete_entry!(entry_id)
    find_entry(entry_id).destroy
  end

  def update_entry!(entry_id, attributes)
    entry = find_entry(entry_id)
    entry.update_attributes(attributes)
  end

  def owner
    self.members.where(role: "Owner").first.try(:user)
  end

  def preview_image
    if url = self.entries.first.try(:media_url)
      url
    else
      "https://cloudinary-a.akamaihd.net/dkgapy5l4/image/upload/v1369972482/no_image_izoyy4.jpg"
    end
  end
end

class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :memory_box

  validates :memory_box_id, uniqueness: { scope: [:user_id], message: "User can only own a MemoryBox once." }
end

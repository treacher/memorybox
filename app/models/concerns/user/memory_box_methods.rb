class User
	module MemoryBoxMethods
		extend ActiveSupport::Concern


		def create_memory_box!(attributes)
		  memory_box = self.memory_boxes.create(attributes)
		  membership = memory_box.members.find_by_user_id(self.id)
		  membership.update_attribute(:role, "Owner")
		  memory_box
		end

		def find_memory_box(memory_box_id)
		  self.memory_boxes.find(memory_box_id)
		end

		def owned_memory_boxes
			self.members.where(role: "Owner").map(&:memory_box)
		end

		def shared_memory_boxes
			self.members.where("role IS NULL OR role != ?", "Owner").map(&:memory_box)
		end

		def leave_memory_box!(memory_box_id)
			self.members.find_by_memory_box_id(memory_box_id).destroy
		end

		def delete_memory_box!(memory_box_id)
		  memory_box = self.find_memory_box(memory_box_id)

		  memory_box.invitations.each do |inv|
		  	inv.receiver.push_delete_invitation(inv) if inv.receiver.present?
		  end

		  memory_box.destroy
		end

		def update_memory_box!(memory_box_id, attributes)
		  memory_box = self.find_memory_box(memory_box_id)
		  memory_box.update_attributes(attributes)
		end

		def admin?(memory_box_id)
		  admins = ["Owner"]
		  member = self.members.find_by_memory_box_id(memory_box_id)
		  
		  admins.include? member.role unless member.nil?
		end
	end
end
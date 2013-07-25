class Api::MemoryBoxesController < Api::ApplicationController
	
	before_filter :require_admin, only: [:update, :destroy]

	def create
		@memory_box = current_user.create_memory_box!(memory_box_params)
		render json: @memory_box
	end

	def index
		query = params[:relationship] == "shared" ? "shared_memory_boxes" : "owned_memory_boxes"
		@memory_boxes = current_user.send(query)
		render json: @memory_boxes
	end

	def show
		@memory_box = current_user.find_memory_box(params[:id])
		render json: @memory_box, serializer: MemoryBoxShowSerializer
	end

	def leave_memory_box
		render json: current_user.leave_memory_box!(params[:memory_box_id])
	end

	def destroy
		@memory_box = current_user.delete_memory_box!(params[:id])
		render json: @memory_box
	end

	def update
		@memory_box = current_user.update_memory_box!(params[:id], memory_box_params)
		render json: @memory_box
	end

	private

	def memory_box_params
		params.require(:memory_box).permit(:title)
	end

	def admin?
		current_user.admin?(params[:id])
	end
	
end

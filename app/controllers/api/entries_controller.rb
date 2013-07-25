class Api::EntriesController < Api::ApplicationController
	
	before_filter :find_memory_box
	before_filter :require_admin, only: [:create, :update, :destroy]
 
	def create
		@entry = @memory_box.create_entry!(entry_params)
		render json: @entry
	end

	def index
		@entries = @memory_box.entries
		render json: @entries
	end

	def show 
		@entry = @memory_box.find_entry(params[:id])
		render json: @entry
	end

	def destroy
		@entry = @memory_box.delete_entry!(params[:id])
		render json: @entry
	end

	def update
		@entry = @memory_box.update_entry!(params[:id], entry_params)
		render json: @entry
	end

	private

	def find_memory_box
		@memory_box = current_user.find_memory_box(params[:memory_box_id])
	end

	def entry_params
		params.require(:entry).permit(:description, :media_url, :media_identifier, :media_format, :media_type)
	end

	def admin?
		current_user.admin?(params[:memory_box_id])
	end
end
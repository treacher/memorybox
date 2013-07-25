class Api::InvitationsController < Api::ApplicationController

	before_filter :require_admin, only: [:create]

	def create
		@success = current_user.invite_to_memory_box(params[:memory_box_id], params[:invitations], params[:message])
		if @success
			render json: { success: "Invitations sent!" }
		end
	end

	def received_invitations
		@received_invitations = current_user.received_invitations
		render json: @received_invitations, each_serializer: ReceivedInvitationsSerializer
	end

	def sent_invitations
		@sent_invitations = current_user.sent_invitations
		render json: @sent_invitations, each_serializer: SentInvitationsSerializer
	end

	def accept
		@invitation = current_user.accept_box_invitation(params[:invitation_id])
		render json: @invitation
	end

	def decline
		@invitation = current_user.decline_invitation(params[:invitation_id])
		render json: @invitation
	end

	def retract
		@invitation = current_user.retract_invitation(params[:invitation_id])
		render json: @invitation
	end

	private

	def admin?
		current_user.admin?(params[:memory_box_id])
	end
end

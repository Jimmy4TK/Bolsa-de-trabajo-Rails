class StatusWorkNotificationsController < ApplicationController
    
    before_action :set_candidate, only:[:create]
	before_action :set_work_notification, only:[:update]
	before_action :set_status_work_notification, only:[:show, :update, :destroy]
	
	def index
	@status_work_notifications=StatusWorkNotification.all
	render status:200, json:{status_work_notifications: @status_work_notifications}
	end
	
	def show
	render status:200, json:{status_work_notification: @status_work_notification}
	end
	
	def create
    @status_work_notification=@candidate.status_work_notifications.build(params.require(:status_work_notification).permit(:work_notification_id))
	if WorkNotification.find_by(id: params[:work_notification_id]).present?
		save_model(@status_work_notification)
	end
    end
	
	def update
	@status_work_notification.assign_attributes(status_work_notifications_params)
	if validate_work_notification
		save_model(@status_work_notification)
	end
	end
	
	def destroy
		if @status_work_notification.destroy
			render status:200
		else
			render_errors_response(@status_work_notification)
		end
	end
	end
	
	private

	#Definimos parametros permitidos para estado aviso de trabajo
	def status_work_notifications_params
	params.require(:status_work_notification).permit(:status)
	end
		
	#Seteamos estado aviso de trabajo
	def set_status_work_notification
	@status_work_notification=StatusWorkNotification.find_by(id: params[:id])
	if @status_work_notification.blank?
		render status:404, json:{message: "Status_work_notification #{params[:id]} doesn't exist"}
		false
	end
	end

	#Seteamos candidato
    def set_candidate
    @candidate = Candidate.find_by(id: params[:candidate_id])
    if @candidate.blank?
        render status:404, json:{message: "Candidate #{params[:candidate_id]} doesno't exist"}
        false
    end
    end

	#Seteamos aviso de trabajo
	def set_work_notification
	@work_notification=WorkNotification.find_by(id: params[:work_notification_id])
	if @work_notification.blank?
		render status:404, json:{message: "Work_notification #{params[:work_notification_id]} doesn't exist"}
		false
	end
	end

	#Validamos que el estado de aviso de trabajo pertenezca al aviso de trabajo
	def validate_work_notification
	if @status_work_notification.work_notification_id!=params[:work_notification_id]
		render status:404, json:{message: "Status work notification #{params[:id]} doesn't correspond to the Work notification #{params[:work_notification_id]}"}
		false
	else
		true
	end
	end
end

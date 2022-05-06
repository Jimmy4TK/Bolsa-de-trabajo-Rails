class WorkNotificationsController < ApplicationController
    
    before_action :set_company, only:[:create,:update,:destroy, :apply, :applyupdate]
	before_action :set_work_notification, only:[:show, :update, :destroy, :apply, :applyupdate]
	before_action :set_candidate, only:[:apply]
	before_action :set_apply, only:[:applyupdate]
	before_action :check_token, only:[:create, :update, :destroy, :apply, :applyupdate]
	
	def index
	@work_notifications=WorkNotification.all
	render status:200, json:{work_notifications: @work_notifications}
	end
	
	def show
	render status:200, json:{work_notification: @work_notification}
	end
	
	def create
	@work_notification=@company.work_notifications.build(work_notifications_params)
	save_model(@work_notification)
	end
	
	def update
	@work_notification.assign_attributes(work_notifications_params)
		save_model(@work_notification)
	end
	
	def destroy
	if @work_notification.destroy
		render status:200
	else
		render_errors_response(@work_notification)
	end
	end
	
	def apply
	@status_work_notification=@work_notification.status_work_notifications.build(status_work_notifications_params_create)
	if StatusWorkNotification.find_by(candidate_id: @candidate_id,work_notification_id: params[:id]).blank?
		if @status_work_notification.save
			save_model(@status_work_notification)
		end
	else
		render status:400, json:{message: "Status_work_notification with Candidate #{@candidate_id} and Work_notification #{params[:id]} already exists"}
	end
	end

	def applyupdate
	if @apply.work_notification_id==@work_notification.id
	@apply.assign_attributes(status_work_notifications_params)
	save_model(@apply)
	else
		render status:400, json:{message: "Status_work_notification #{params[:status_id]} doesn't correspond to Work_notification #{params[:id]}"}
	end
	end

	private
	
	#Definimos parametros permitidos para aviso de trabajo
	def work_notifications_params
	params.require(:work_notification).permit(:name)
	end
	#Definimos parametros permitidos para estado aviso de trabajo
	def status_work_notifications_params
		params.require(:status_work_notification).permit(:status)
	end
	#Definimos parametros permitidos para estado aviso de trabajo(en el create)
	def status_work_notifications_params_create
	params.require(:status_work_notification).permit(:candidate_id)
	end
		
	#Seteamos aviso de trabajo
	def set_work_notification
	@work_notification=WorkNotification.find_by(id: params[:id])
	if @work_notification.blank?
		render status:404, json:{message: "Work_notification #{params[:id]} doesn't exist"}
		false
	end
	end
    
	#Seteamos compañia
    def set_company
	@company = Company.find_by(id: params[:company_id])
	if @company.blank?
		render status:404, json:{message: "Company #{params[:company_id]} doesn't exist"}
		false
	end
	end

	#Seteamos candidato
	def set_candidate
	@candidate_id=status_work_notifications_params_create[:candidate_id]
	@candidate=Candidate.find_by(id: @candidate_id)
	if @candidate.blank?
		render status:404, json:{message: "Candidate #{@candidate_id} doesn't exist"}
		false
	end
	end

	#Seteamos estado aviso de trabajo
	def set_apply
	@apply=StatusWorkNotification.find_by(id: params[:status_id])
	if @apply.blank?
		render status:404, json:{message: "Status_work_notification #{params[:status_id]} doesn't exist"}
		false
	end
	end

	#Validamos que el token enviado pertenezca a la compañia
	def check_token
	if request.headers["Authorization"] != "Bearer #{@company.token}"
		render status:400, json:{message: "Token isn't valid"}
		false
	end
	end
end
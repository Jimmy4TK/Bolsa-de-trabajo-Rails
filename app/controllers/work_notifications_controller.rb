class WorkNotificationsController < ApplicationController
    
    before_action :set_company, only:[:create,:update,:destroy]
	before_action :set_work_notification, only:[:show, :update, :destroy]
	
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
	if validate_company
		save_model(@work_notification)
	end
	end
	
	def destroy
	if validate_company
		if @work_notification.destroy
			render status:200
		else
			render_errors_response(@work_notification)
		end
	end
	end
	
	private
	
	#Definimos parametros permitidos para aviso de trabajo
	def work_notifications_params
	params.require(:work_notification).permit(:required_profession)
	end
	
	#Seteamos aviso de trabajo
	def set_work_notification
	@work_notification=WorkNotification.find_by(id: params[:id])
	if @work_notification.blank?
		render status:404, json:{message: "Work_notification #{params[:id]} does not exist"}
		false
	end
	end
    
	#Seteamos compañia
    def set_company
	@company = Company.find_by(id: params[:company_id])
	if @company.blank?
		render status:404, json:{message: "Company #{params[:company_id]} does not exist"}
		false
	end
	end

	#Validamos que el aviso de trabajo pertenezca a la compañia
	def validate_company
		if @company.id!=@work_notification.company_id
			render status:404, json:{message: "Work_notification #{params[:id]} doesn't correspond to the Company #{params[:company_id]}"}
			false
		else
			true
		end
end

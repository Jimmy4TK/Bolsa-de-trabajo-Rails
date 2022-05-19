class CompaniesController < ApplicationController
	
	before_action :set_company, only:[:show, :update, :destroy]
	before_action :check_token, only:[:update, :destroy]
	
	def index
	@companies=Company.all.select("id,name,created_at,updated_at")
	render status:200, json:{companies: @companies}
	end
	
	def show
	@company = @company.select("id,name,created_at,updated_at")
	render status:200, json:{company: @company}
	end
	
	def create
	@company=Company.new(company_params)
	save_model(@company)
	end
	
	def update
	@company.assign_attributes(company_params)
	save_model(@company)
	end
	
	def destroy
	if @company.destroy
		render status:200
	else
		render_errors_response(@company)
	end
	end
	
	private
	
	#Definimos parametros permitidos para compañia
	def company_params
	params.require(:company).permit(:name)
	end
	
	#Seteamos compañia
	def set_company
	@company = Company.find_by(id: params[:id])
	if @company.blank?
		render status:404, json:{message: "Company #{params[:id]} doesn't exist"}
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

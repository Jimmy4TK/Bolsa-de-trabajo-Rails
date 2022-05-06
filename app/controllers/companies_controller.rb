class CompaniesController < ApplicationController
	
	before_action :set_company, only:[:show, :update, :destroy]
	before_action :check_token, only:[:update, :destroy]
	
	def index
	@companies=Company.all
	render status:200, json:{companies: @companies}
	end
	
	def show
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
	
	def company_params
	params.require(:company).permit(:name)
	end
	
	def set_company
	@company = Company.find_by(id: params[:id])
	if @company.blank?
		render status:404, json:{message: "Company #{params[:id]} doesn't exist"}
		false
	end
	end

	def check_token
	if request.headers["Authorization"] != "Bearer #{@company.token}"
		render status:400, json:{message: "Token isn't valid"}
		false
	end
	end
end

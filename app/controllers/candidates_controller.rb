class CandidatesController < ApplicationController

before_action :set_candidate, only:[:show,:update,:destroy]

	def index
	@candidates = Candidate.all
	render status:200, json: {candidates: @candidates}
	end
	
	def show
	render status:200, json: {candidate: @candidate}
	end
	
	def create
	@candidate=Candidate.new(candidate_params)
	save_model(@candidate)
	end
	
	def update
	@candidate.assign_attributes(candidate_params)
	save_model(@candidate)
	end
	
	def destroy
	if @candidate.destroy
		render status:200, json:{}
	else
		render_errors_response(@candidate)
	end
	end

	private
	
	#Definimos parametros permitidos para candidato
	def candidate_params
	params.require(:candidate).permit(:name, :profession)
	end
	
	#Seteamos candidato
	def set_candidate
	@candidate = Candidate.find_by(id: params[:id])
	if @candidate.blank?
		render status:404, json:{message: "Candidate #{params[:id]} doesn't exist"}
		false
	end
	end
end

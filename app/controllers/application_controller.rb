class ApplicationController < ActionController::Base
skip_before_action :verify_authenticity_token

def render_errors_response(model)
	render status:400, json:{ message: model.errors.details }
end
def save_model(model)
	if model.save
		render status:200, json:{model: model}
	else
		render_errors_response(model)
	end
end
end
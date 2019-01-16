class ApplicationController < ActionController::Base

	rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
	rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
	rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing


	before_action :set_default_response_format

	protected

	def set_default_response_format
	  request.format = :json
	end
	# rescue_from StandardError, :with => :handle_standard_error

	def handle_parameter_missing(error)
		message = error.to_s
		render json: {error: message}, status: 400
	end

	def handle_record_not_found(error)
		message = error.to_s
		render json: {error: message}, status: 404
	end

	def handle_record_invalid(error)
		message = error.to_s
		render json: {error: message}, status: 400
	end

	def handle_standard_error(error)
		render json: {
			error: "An error occurred"
		}, status: 500
	end
end

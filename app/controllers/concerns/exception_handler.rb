module ExceptionHandler
    # provides the more graceful `included` method
    extend ActiveSupport::Concern
  
    included do
      rescue_from ActiveRecord::RecordNotFound do |e|
        json_response({ message: "Not found." }, :not_found) #404,
      end
  
      rescue_from ActiveRecord::RecordInvalid do |e| #tried to create a todo that does not pass validation for parameters.
        e.message.slice! "Validation failed: "
        json_response({ message: e.message }, :unprocessable_entity) #422
      end
    end
  end
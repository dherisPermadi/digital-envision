# frozen_string_literal: true

# class of json response
module Response
  def json_response(object, status = :ok)
    render json: { data: object }, status: status
  end

  def response_success(message, data = nil, code = 200)
    render json: { code: code, status: 'success', message: message, data: data }, status: code
  end

  def response_error(message, data = nil, code = 400)
    render json: { code: code, status: 'error', message: message, error: data }, status: code
  end
end

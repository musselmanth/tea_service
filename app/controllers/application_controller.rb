class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(exception)
    render_json(ErrorSerializer.new([exception.message]), :not_found)
  end
  
  def render_json(hash, status = :ok)
    render json: hash, status: status
  end
end

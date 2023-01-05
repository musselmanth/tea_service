class ErrorSerializer

  def initialize(errors)
    @errors = errors
  end

  def to_hash
    {
      message: "your request could not be completed",
      errors: @errors
    }
  end
end
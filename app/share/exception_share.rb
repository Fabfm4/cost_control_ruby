module ExceptionShare
  extend ActiveSupport::Concern

  class ModelException < StandardError
    attr_accessor :message, :status, :code, :data

    def initialize(message, status = 400, code = 0, data = nil)
      @message = message
      @status = status
      @code = code
      @data = data
    end
  end
end

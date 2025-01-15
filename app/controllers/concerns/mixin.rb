module Mixin
  extend ActiveSupport::Concern

  def add_user_id_to_params
    puts @model_name
    params[@model_name][:user_id] = @current_user.id
  end

  def paginate
    puts session
    if response.body.present?
      puts response.body.class
      response.body = { data: JSON.parse(response.body) }.to_json
    end
  end

  private
  def model_params(model, model_name)
    fields = model.attribute_names.map { |attr| attr.to_sym }
    params.expect(Hash[model_name, fields])
  end
end

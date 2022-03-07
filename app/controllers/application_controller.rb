class ApplicationController < ActionController::Base
  def index
    @forms_count = Form.count
    @responses_count = Response.count

    render template: 'home.html.slim'
  end
end

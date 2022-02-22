json.extract! response, :id, :form_id, :content, :respondent, :created_at, :updated_at
json.url response_url(response, format: :json)

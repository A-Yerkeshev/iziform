class Response < ApplicationRecord
  belongs_to :form
  serialize :content, Hash
end

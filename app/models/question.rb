class Question < ApplicationRecord
	validates :form_id, presence: true, numericality: { only_integer: true }
	validates :content, presence: true

	serialize :options, Array
end

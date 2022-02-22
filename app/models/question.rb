class Question < ApplicationRecord
	validates :form_id, presence: true, numericality: { only_integer: true }

	serialize :options, Array
end

class Question < ApplicationRecord
	belongs_to :form

  QUESTION_TYPES = {
    text: 0,
    one_choice: 1,
    multiple_choices: 2
  }

	validates :form_id, presence: true, numericality: { only_integer: true }
	validates :content, presence: true

	serialize :options, Array
end

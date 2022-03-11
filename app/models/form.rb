class Form < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :questions,inverse_of: :form, dependent: :destroy
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end

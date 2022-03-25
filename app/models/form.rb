class Form < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :questions,inverse_of: :form, dependent: :destroy
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, length: { maximum: 100 }

  after_initialize :generate_token

  private
    def generate_token
      charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
      self.token ||= Array.new(20) { charset.sample }.join if new_record?
    end
end

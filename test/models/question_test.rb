require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  def setup
    @q = Question.new(form_id: 1, content: 'Left, right or center?', options: ['left', 'right', 'center'], question_type: 'radiobutton')
  end

  test "Should save queston" do
    assert @q.save
  end

  test "Form id should be valid integer" do
    @q.form_id = nil
    assert_not @q.valid?

    @q.form_id = 'string'
    assert_not @q.valid?

    @q.form_id = 0.98
    assert_not @q.valid?
  end
end

require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  test "Should save queston" do
    q = Question.new(form_id: 1, content: 'Left, right or center?', options: ['left', 'right', 'center'], question_type: 'radiobutton')
    assert q.save
  end
end

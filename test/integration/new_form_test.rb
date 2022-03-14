require "test_helper"

class NewFormTest < ActionDispatch::IntegrationTest
  test 'Create form with valid credentials' do
    # {
    #   "authenticity_token"=>"[FILTERED]",
    #   "form"=>{
    #     "name"=>"Form 1",
    #     "questions_attributes"=>{
    #       "1647249616026"=>{
    #         "content"=>"Q1\r\n1\r\n2\r\n3",
    #         "question_type"=>"0",
    #         "_destroy"=>"false"},
    #       "1647249621878"=>{
    #         "content"=>"Q2\r\na\r\nb\r\nc",
    #         "question_type"=>"0",
    #         "_destroy"=>"false"
    #       }
    #     }
    #   },
    #   "commit"=>"Create Form"
    # }



    params = {form: {
      name: 'New form',
      questions_attributes: {
        qa0: {
          content: 'What is your full name?&&Option',
          question_type: 0,
          _destroy: false
        },
        qa1: {
          content: 'What is your eyes colour?\n&&brown\n&&blue&&green',
          question_type: 1,
          _destroy: false
        },
        qa2: {
          content: 'What languages you speak?&&English\n&&Spanish\n&&Chinese&&Arabic',
          question_type: 2,
          _destroy: false
        }
      }
    }}

    get new_form_path
    assert_difference 'Form.count', 1 do
      post forms_path, params: params
    end
    follow_redirect!
    assert_template 'forms/show'

    # Verify that form name is correct
    # Verify that questions number is correct
    # Verify that each questions text is correct
    # Verify that each questions options are correct
  end

  test 'Reject form with invalid credentials' do
  end

end

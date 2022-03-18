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

    questions = [
      {
        text: 'What is your full name?',
        options: ['Option']
      },{
        text: 'What is your eyes colour?',
        options: ['brown', 'blue', 'green']
      },{
        text: 'What languages you speak?',
        options: ['English', 'Spanish', 'Chinese', 'Arabic']
      }
    ]

    params = {form: {
      name: 'New form',
      questions_attributes: {
        qa0: {
          content: "#{questions[0][:text]}\n#{questions[0][:options][0]}",
          question_type: 0,
          _destroy: false
        },
        qa1: {
          content: "#{questions[1][:text]}\n#{questions[1][:options][0]}\n#{questions[1][:options][1]}\n#{questions[1][:options][2]}",
          question_type: 1,
          _destroy: false
        },
        qa2: {
          content: "#{questions[2][:text]}\n#{questions[2][:options][0]}\n#{questions[2][:options][1]}\n#{questions[2][:options][2]}\n#{questions[2][:options][3]}",
          question_type: 2,
          _destroy: false
        }
      }
    }}

    get new_form_path
    assert_response :success

    assert_difference 'Form.count', 1 do
      post forms_path, params: params
    end

    assert_redirected_to form_path(Form.last)
    follow_redirect!

    # Verify that form name is correct
    assert_select 'h2', 'New form'

    # Verify that questions number is correct
    assert_select 'h6', form_path(Form.last), count: 3

    # Verify that each questions text is correct
    assert_select 'h6' do |tags|
      tags.each_with_index do |tag, i|
        assert tag[:text] == questions[i][:text]
      end
    end

    # Verify that each questions options are correct

  end

  test 'Reject form with invalid credentials' do
  end

end

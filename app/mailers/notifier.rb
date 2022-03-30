class Notifier < ActionMailer::Base
  default from: 'arman.yerkeshev@edu.keuda.fi'
  layout 'mailer'

  def new_form_email(form)
    @form = form
    mail(to: form.email, subject: 'Your form was successfully created.')
  end

  def new_response_email(response, form)
    @response = response
    @form = form
    mail(to: form.email, subject: "Your form '#{form.name}' has new response.")
  end
end

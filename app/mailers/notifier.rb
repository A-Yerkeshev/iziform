class Notifier < ActionMailer::Base
  default from: 'arman.yerkeshev@edu.keuda.fi'
  layout 'mailer'

  def new_form_email(form)
    @form = form
    mail(to: form.email, subject: 'Your form was created.')
  end
end

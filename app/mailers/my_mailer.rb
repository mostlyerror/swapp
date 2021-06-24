class MyMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: '../views/devise/mailer' # to make sure that your mailer uses the devise views
  # If there is an object in your application that returns a contact email, you can use it as follows
  # Note that Devise passes a Devise::Mailer object to your proc, hence the parameter throwaway (*).
  default from: ->(*) { 'bjohnson@codeforamerica.org' } 

  def confirm_user(user)
    @user = user
    mail(to: @user.email, subject: 'swapp email confirmation')
  end
end
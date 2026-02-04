class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_user_email.subject
  #
  default from: "noreply@fotobook.com"
  #Ex:- :default =>''
  def new_user_email
    @user = params[:user]
    send_mail = @user ? @user.email : "mock@example.com"
    puts "--------------------------------"
    puts "Sending email to #{send_mail}"
    puts "--------------------------------"
    mail from: "no-reply@fotobook.com", to: send_mail, subject: "Welcome to Fotobook!"
  end
end

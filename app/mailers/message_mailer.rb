class MessageMailer < ApplicationMailer
  default from: 'notifications@lff-admin.com'

  def new_message_notification(message)
    @message = message
    email = ENV['notification_recipient_email']
    mail(to: email, subject: 'Message received at Lefkofsky Foundation website')
  end
end

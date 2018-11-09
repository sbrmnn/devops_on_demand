namespace :chat_notification_email do
  # Give a description for the task
  desc "Send chat notification email."
  # Define the task
  task send: :environment do
    SendChatNotificationEmailsToRecipients.new.call
  end
end
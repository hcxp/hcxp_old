ActionMailer::Base.smtp_settings = {
  :address => ENV['EMAIL_HOST'],
  :port => ENV['EMAIL_PORT'],
  :domain => Rails.application.domain,
  :enable_starttls_auto => true,
  user_name:            ENV['EMAIL_LOGIN'],
  password:             ENV['EMAIL_PASS'],
  authentication:       'plain',
}

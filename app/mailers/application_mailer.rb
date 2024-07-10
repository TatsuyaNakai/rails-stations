class ApplicationMailer < ActionMailer::Base
  default from: '"demo_app" <from@example.com>'
  layout 'mailer'
end

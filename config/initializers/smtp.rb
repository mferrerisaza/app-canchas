ActionMailer::Base.smtp_settings = {
  authentication: 'plain',
  address: "smtp.mailgun.org",
  port: 587,
  domain: "sandbox9ff87b1daae349b8915ceb661b01b421.mailgun.org",
  user_name: "postmaster@sandbox9ff87b1daae349b8915ceb661b01b421.mailgun.org",
  password: "07b9de007e0435bedd0b5e257207077e-115fe3a6-3428bfa7",
  enable_starttls_auto: true
}


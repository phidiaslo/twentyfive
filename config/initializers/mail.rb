#MANDRILL_API_KEY = "ol0z0gFdZO-pMaAVfvCiLw"

ActionMailer::Base.smtp_settings = {
  address: "smtp.mandrillapp.com",
  port: 587,
  enable_starttls_auto: true,
  user_name: "phidiaslo@gmail.com",
  password: "ol0z0gFdZO-pMaAVfvCiLw",
  #password: MANDRILL_API_KEY,
  authentication: "login"
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"
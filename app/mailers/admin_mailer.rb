class AdminMailer < ApplicationMailer
  default from: "TwentyFive.com <no-reply@twentyfive.com>"
  default to: "phidiaslo@gmail.com"

  def mandrill_client
  	@mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  end
  
  def new_gig(gig)
  	@gig = gig
    mail(subject: "New Gig: #{@gig.gig_title}")
  end

  #def new_gig(gig)
  #  template_name = "new-gig"
  #  template_content = []
  #  message = {
  # 	to: [{email: "phidiaslo@gmail.com", name: "Phidias Lo"}],
  # 	subject: "New Gig: #{gig.gig_title}",
  # 	merge_vars: [
  #         {rcpt: "phidiaslo@gmail.com",
  #          vars: [
  #          	{name: "GIG_TITLE", content: gig.gig_title}
  #         ]
  #        }
  # 	 ]
  #     }

  # mandrill_client.messages.send_template template_name, template_content, message
  #end
end

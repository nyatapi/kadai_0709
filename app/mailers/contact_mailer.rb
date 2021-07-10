class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: 'xo224324xo@icloud.com', subject: "Complete"
  end
end

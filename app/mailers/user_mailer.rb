class UserMailer < ApplicationMailer
    default from: 'no-reply@jungle.com'

    def email_receipt(order)
        @order = order
        mail(to: @order.email, subject: "Thanks for your order! Order Id: #{@order.id}")
    end
end

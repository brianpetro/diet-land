class PrelaunchController < ApplicationController
  def home
  end
  def subscribe
    email = params[:subscribe][:email]
    if valid_email?(email)
      api = Mailchimp::API.new("803acd89f40058142014bf89a55449c3-us6")
      api.listSubscribe({id: "b1dcf737f3", email_address: email})
      redirect_to root_path, notice: "Almost There!"
    else
      redirect_to root_path, alert: "Please Enter a Valid Email"
    end
  end
  def facebook
    api = Mailchimp::API.new("803acd89f40058142014bf89a55449c3-us6")
    api.listSubscribe({id: "b1dcf737f3", email_address: env["omniauth.auth"]['info']['email']})
    redirect_to root_path, notice: "Almost There!"
  end

private
  def valid_email?(email)
    v = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? &&
     (email =~ v)
  end
end

class PrelaunchController < ApplicationController
  def home
  end
  def subscribe
    api = Mailchimp::API.new("803acd89f40058142014bf89a55449c3-us6")
    email = params[:subscribe][:email]
    api.listSubscribe({id: "b1dcf737f3", email_address: email})
    redirect_to root_path, notice: "subscribed"
  end
end

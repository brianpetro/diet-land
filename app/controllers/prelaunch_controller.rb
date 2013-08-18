class PrelaunchController < ApplicationController
  before_action :set_email
  def home
    if @email.present?
      @button = "Re-Submit"
    else
      @button = "Join!"
    end
  end
  def subscribe
    if env["omniauth.auth"].present?
      api = Mailchimp::API.new("803acd89f40058142014bf89a55449c3-us6")
      api.listSubscribe({id: "b1dcf737f3", email_address: env["omniauth.auth"]['info']['email']})
      email = env["omniauth.auth"]['info']['email']
      session[:email] = email
      redirect_to '/'
    elsif params[:subscribe].present?
      email = params[:subscribe][:email]
      if valid_email?(email)
        api = Mailchimp::API.new("803acd89f40058142014bf89a55449c3-us6")
        api.listSubscribe({id: "b1dcf737f3", email_address: email})
        @email = email
        session[:email] = email
        redirect_to '/'
      end
    else
      redirect_to '/'
    end
  end

private
  def valid_email?(email)
    v = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? &&
     (email =~ v)
  end

  def set_email
    if session[:email].present?
      @email = session[:email]
    end
  end
end

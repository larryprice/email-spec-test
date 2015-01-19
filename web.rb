require 'sinatra/base'
require 'pony'
require 'haml'

# stub
class User
  attr_accessor :email
  def self.create!(p)
    u = User.new
    u.email = p['email']
    return u
  end

  def generate_verification_hash
    "somegarbage"
  end
end

class TestWeb < Sinatra::Base

  post '/signup' do
    user = User.create! params

    url = "#{request.base_url}/account/reset/#{user.generate_verification_hash}"

    Pony.mail(
      to: user.email,
      from: "MyApp Help Desk <noreply@myapp.com>",
      subject: "MyApp Account Verification",
      body: "A request has been made to verify your MyApp account (https://myapp.com)." +
            "If you made this request, go to " + url + ". If you did not make this request, ignore this email.",
      html_body: haml(
        :verify_account_email,
        layout: false,
        locals: {
          email: user.email,
          date: DateTime.now.strftime("%H:%M:%S%P %B %d, %Y"),
          ip: request.ip,
          url: url
        }
      )
    )

    redirect :signup
  end

  get '/signup' do
    haml :signup
  end
end
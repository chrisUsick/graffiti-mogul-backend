class MobileAuthController < ApplicationController
  def sign_in
    token = params[:token]

    validate_response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{token}")

    audience = ENV['WEB_CLIENT_ID']
    if validate_response.code == 200
      data = JSON.parse validate_response.body
      raise StandardError.new('no audience') unless data['aud'] == audience
      user = User.find_for_verified_token_response data.symbolize_keys
      headers = user.create_new_auth_token
      response.headers.merge! headers
      render json: user
    else
      p validate_response.code
      render json: validate_response
    end

  end
end

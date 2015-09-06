OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '642486556269-s23kbrc1lekhvqch3l54tg3ap7o5prgp.apps.googleusercontent.com', 'T0HebqeHfYL9KPTobcWGqLp5', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end

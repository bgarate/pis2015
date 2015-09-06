OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '900751170201-6d95edm3b2v8hn07bs2fv284kpog5lnh.apps.googleusercontent.com', 'fH6_zpCZqeq7FTlizY98MmxW', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end

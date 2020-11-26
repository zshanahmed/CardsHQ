Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "370996867484023", "ec3ee5a2b553020583adcfcd9579211a"
end
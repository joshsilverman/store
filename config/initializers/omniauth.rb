# Change this omniauth configuration to point to your registered provider

# Since this is a registered application, add the app id and secret here
APP_ID = 'YE0NYveQGoFsNLX220Dy5g'
APP_SECRET = 'aqpGBedDnHFyp5MmgT8KErr9D015ScmaY8r3vHg5C0'

# Update your custom Omniauth provider URL here
CUSTOM_PROVIDER_URL = STUDYEGG_USER_MANAGER_PATH

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, APP_ID, APP_SECRET
end

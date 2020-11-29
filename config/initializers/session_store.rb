# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_Team1_SELT2020_session'
Rails.application.config.session_store :active_record_store, key: '_devise-omniauth_session', domain: 'localhost'
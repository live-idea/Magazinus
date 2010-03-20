# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Magazinus_session',
  :secret      => 'f99fe68032ae61451de2de0da0a5996d5646440c7a5955b20c1242752949f12269f12a0e2d30be740d81158c340bd86d95848ae75f63c3749e4872365b62e452'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

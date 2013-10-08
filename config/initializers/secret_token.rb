# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Parrot::Application.config.secret_key_base = 'e10d26419c13d35a5dd460db4d41a4deadfa84eb27fcdb291e50e591b9bb3223dd8507b962675862449a05f03716beb4ee9b1597da228024b54824c605600c67'

import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# Start the phoenix server if environment is set and running in a release
if System.get_env("PHX_SERVER") && System.get_env("RELEASE_NAME") do
  config :food_order, FoodOrderWeb.Endpoint, server: true
end

if config_env() == :prod do
  # Waffle GCS (Google cloud, aws, etc...)
  config :waffle,
    storage: Waffle.Storage.Google.CloudStorage,
    bucket: System.get_env("GCP_BUCKET")

  # goth (Google auth)
  config :goth,
    json: "{\n  \"type\": \"service_account\",\n  \"project_id\": \"deft-clarity-349619\",\n  \"private_key_id\": \"75f45c95269a1fa3e31e372b6f40b146696d3ec3\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCsW4r2Kbatxgc7\\ndWQgYK0XmEYMThmmIVoWmhLNuH6+FeIxYIjGXIjitXQ7rigNz3KBs74FJZawjsGd\\npWoRDXEJLpuF9Vap/7BubzH7RNRSCm2fv6uT2KqtTpjstiW4CrgG5Fny33lIitPe\\n0XAAwnnwMNWMxV7ZfEqfsfPxAg89eCtwZrWn1cpzYfDR7tb0rfzOY1Q7/dZUKKYp\\n6L3/udzJ+zywf3QiOfnHLSd7TxTIx4vNtc8pzqQFVEYJany7JEc9BENCucRrz0Af\\nRyUDM5/6Y/jWj7QPV9lHSSlNwCpfKiDyiQ1HG8fwIvCAOT5GGXJTEzpIcL+Vj+o8\\nilZ7HUvLAgMBAAECggEAMArON6JV8KcXofutPpcj+EUyFUD5xkRao50rq5sG/P4F\\nkATb6wqk/yhb7zyynnLZ9IxA5ZdeIvWPw1z1rS4leU07/YFuuDD0oTuuX18GnZ2Z\\ng+M9tJa6sFcNqkF1TxDxzb390oR2/oDv4JZZVWTf71L1W2kycIXEGTJVkDKmQ9gT\\nimkeCJiG2CIs2jXWKTN44bIMmC9UpKiuFnC1WYCsPVa77GvDCdkeqZN9KICU7jVT\\n2gJdh0vfs2E9RtwLLZ9eTA9tsVSkpY5qBaNub0LzNDMu/O+XoaGhujAFUgmjdgPI\\nuibTG1wa0uI0cMoAroE5RJH4u/Axj7HxgQ2v7gHlBQKBgQDVGOKxtZggNmn5w0XP\\ny5k3GqQMhYZ9ZUS/BA5wqLavhKXiRia75P1CpZgmVQQOk5lXdxBDaBIJIfSYDjX/\\nwVVmQJFbHmImrEqXwejC5raXbgPffYsX0xEooGrzXnpUbbXKk5v8L3PxE3hRr17t\\nNp6e1FjWKzSBROw0yEtu/PgUBQKBgQDPDuvRTcd6psmpw88epbgsg2EEpxZBC+ib\\nsCGfQWqlQE2COhY+usk4GxzL5YuS0A8kREkL15QwViRUC5jMsR/C9IjphMni53pn\\nxg25kdfJzHoQcnrxdxiWCrbIRIGa8wN4+qthNSbsHUNwJHX77rzM0DHkDk+8oaIS\\nyX84uNE5jwKBgHmMtlHzaRCGuTA0CDAczAo4cfaKe0ovZ2UlZS8xrPK00QIeTZ3D\\nYgqP9hd3StcdrcvMKESqqg73hVLuWDLIDnRCxCabUBULFYk2nBQAEYqSwDbMn3g5\\ndoIb7qVe8JwT8CvawpC4aIPMPUcqpxTboOKr8PhIsKxDqg/5Z72pIcAZAoGAS8Tc\\nCnV536oU9aiPrFlcMf3JjNhPznG7Ju2nAA4CJoKHWnZDGaVkaMGTIhHXp1u3jr/m\\nMw0qTx3WoWK1AYJ3avHs//b1obCvHDZfY165JkFLEaWy05WPS6iUBmj7PGZdCPJB\\nsIqwuYpj2S+edRiBwjkVaKzMBOzo0BMoGOuYtIUCgYEAxVDaFpQgItKY4wq/1AdC\\n8VYgu9g5eF4rgy/O2SAS3QhdgIC0QnNaC4s2gMUKjF/lCfY8r5RFiDCpLvPESqyi\\n+ze1lGh0o20SiJl8UBP5hSP6g6hqMhdXSEl55I08/IxnGzI/Q+hqBOmmWeZa2a/1\\nyXwOvixMFgc7rYumbkyZPWE=\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"bucket-elxpro-permission@deft-clarity-349619.iam.gserviceaccount.com\",\n  \"client_id\": \"108628551314340772547\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/bucket-elxpro-permission%40deft-clarity-349619.iam.gserviceaccount.com\"\n}\n"

  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

  config :food_order, FoodOrder.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    socket_options: maybe_ipv6

  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :food_order, FoodOrderWeb.Endpoint,
    url: [host: host, port: 443],
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base,
    check_origin: false

  # ## Using releases
  #
  # If you are doing OTP releases, you need to instruct Phoenix
  # to start each relevant endpoint:
  #
  #     config :food_order, FoodOrderWeb.Endpoint, server: true
  #
  # Then you can assemble a release by calling `mix release`.
  # See `mix help release` for more information.

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Also, you may need to configure the Swoosh API client of your choice if you
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :food_order, FoodOrder.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
end

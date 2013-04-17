if Rails.env.test?
  Rails.application.config.middleware.insert_before \
    Apartment::Elevators::Subdomain,
    FakeBraintreeRedirect
end

Rails.application.config.middleware.use Apartment::Elevators::Subdomain

Apartment.excluded_models = ["Subscribem::Account", 
                             "Subscribem::User",
                             "Subscribem::AccountsUser"]

Apartment.database_names = lambda{ Subscribem::Account.pluck(:subdomain) }

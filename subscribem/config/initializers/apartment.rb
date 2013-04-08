Rails.application.config.middleware.use Apartment::Elevators::Subdomain

Apartment.excluded_models = ["Subscribem::Account", 
                             "Subscribem::User",
                             "Subscribem::AccountsUser",
                             "Subscribem::Plan"]

Apartment.database_names = lambda{ Subscribem::Account.pluck(:subdomain) }

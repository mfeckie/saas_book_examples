namespace :subscribem do
  desc "Import plans from Braintree"
  task :import_plans => :environment do
    BraintreePlanFetcher.store_locally
  end
end

# desc "Explaining what the task does"
# task :subscribem do
#   # Task goes here
# end

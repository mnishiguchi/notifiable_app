namespace :import do
  desc "Import users from csv"
  task users: :environment do                     # Tell Rake to load the Rails app because we want to access User model.
    filename = File.join Rails.root, "users.csv"  # The absolute path to the CSV file.
    user_import = User::Import.new(file: File.open(filename))
    user_import.import

    puts "Imported #{import.imported_count} users"
    puts user_import.errors.full_messages
  end
end

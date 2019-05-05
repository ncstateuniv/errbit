require 'securerandom'

puts "Seeding database"
puts "-------------------------------"

# Create an initial Admin User
admin_username = ENV['ERRBIT_ADMIN_USER'] || "errbit"

def admin_email
   return 'expertiza-support@lists.ncsu.edu' if heroku_pr_review_app?

  "expertiza-support@lists.ncsu.edu"
end

def admin_pass
  return 'errbit' if heroku_pr_review_app?

  @admin_pass ||= "errbit"
end

def heroku_pr_review_app?
  app_name = ENV.fetch("HEROKU_APP_NAME", "")
  app_name.include?("errbit-deploy-pr-")
end

puts "Creating an initial admin user:"
puts "-- username: #{admin_username}" if Errbit::Config.user_has_username
puts "-- email:    #{admin_email}"
puts "-- password: #{admin_pass}"
puts ""
puts "Be sure to note down these credentials now!"
puts "\nNOTE: DEMO instance, not for production use!" if heroku_pr_review_app?

user = User.find_or_initialize_by(email: admin_email)

user.name = 'Errbit Admin'
user.password = admin_pass
user.password_confirmation = admin_pass
user.username = admin_username if Errbit::Config.user_has_username
user.admin = true
user.save!

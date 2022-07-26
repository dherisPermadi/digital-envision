namespace :generate_default_data do
  desc "Generate Uvent and Users data"
  task create_event_and_users: :environment do
    time_zone = ["Central America", "Eastern Time (US & Canada)", "Melbourne", "Melbourne", "Sydney", "Jakarta", "Singapore", "Tokyo"]
    birthday  = ["1992/07/27", "2000/07/29", "1988/07/28", "1995/07/27"]

    Event.create(title: 'Birthday', message: '“Hey, {0} it’s your birthday', send_time: '09:00', message_params: ["full_name"])

    15.times do |i|
      first_name = "User#{i}"
      email      = "#{first_name}@mailinator.com"

      User.create(first_name: first_name, last_name: "Test", email: email, birthday: birthday.sample, time_zone: time_zone.sample)
    end
  end
end

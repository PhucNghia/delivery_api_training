STATUSES = ["not received", "received", "received product", "is delivering", "delivered", "Cancel"]

namespace :db do

  task create_status: :environment do
    return if STATUSES.length == Status.count
    STATUSES.each do |status|
      Status.create text: status
    end
  end
end

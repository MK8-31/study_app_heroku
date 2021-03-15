namespace :notification do
    desc "reminder/一日に一回動かす。"
    task :reminder => :environment do
        today = Date.today
        notices = Notification.all
        n = notices.count

        notices.each do |notice|
            user = notice.user
            if today + 1 == notice.start_time.to_date && !notice.over?
                Reminder.create(notification_id: notice.id,user_id: user.id,action: "warning")
                UserMailer.remind(user,notice).deliver_now
            end 

            if notice.reminder.nil? && today > notice.start_time.to_date
                Reminder.create(notification_id: notice.id,user_id: user.id,action: "expired")
            elsif notice.reminder.present? && today > notice.start_time.to_date
                notice.reminder.update(action: "expired")
                notice.update(over: true)
            end 

            n -= 1
            puts "残り#{n}/#{notices.count}"
        end 
    end
end

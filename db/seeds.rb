User.create!(name: "Example User",
             email: "example@yakhoo.coma",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
21.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@yakhoo.coa.jp"
    password = "password"
    
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
end 

(1..6).each do |n|
    name = "math-#{n}"
    day_of_week = "Wednesday"
    th_period = n
    user = User.first
    
    user.subjects.create!(name: name,day_of_week: day_of_week,th_period: th_period,definitely: true)
end 

(1..6).each do |n|
    name = "english-#{n}"
    day_of_week = "Monday"
    th_period = n
    user = User.first
    
    user.subjects.create!(name: name,day_of_week: day_of_week,th_period: th_period,definitely: true)
end 

(1..6).each do |n|
    name = "calculus-#{n}"
    day_of_week = "Tuesday"
    th_period = n
    user = User.first
    
    user.subjects.create!(name: name,day_of_week: day_of_week,th_period: th_period,definitely: true)
end 

(1..6).each do |n|
    name = "programing-#{n}"
    day_of_week = "Thursday"
    th_period = n
    user = User.first
    
    user.subjects.create!(name: name,day_of_week: day_of_week,th_period: th_period,definitely: false)
end 
(1..6).each do |n|
    name = "General mechanics-#{n}"
    day_of_week = "Friday"
    th_period = n
    user = User.first
    
    user.subjects.create!(name: name,day_of_week: day_of_week,th_period: th_period,definitely: false)
end 
(1..6).each do |n|
    name = "psychology-#{n}"
    day_of_week = "Saturday"
    th_period = n
    user = User.first
    
    user.subjects.create!(name: name,day_of_week: day_of_week,th_period: th_period,definitely: false)
end 

(1..6).each do |n|
    name = "psychology-#{n}"
    th_period = n
    user = User.second
    user.subjects.create!(name: name,day_of_week: "Monday",th_period: th_period,definitely: true)
    user.subjects.create!(name: name,day_of_week: "Tuesday",th_period: th_period,definitely: false)
    user.subjects.create!(name: name,day_of_week: "Wednesday",th_period: th_period,definitely: true)
    user.subjects.create!(name: name,day_of_week: "Thursday",th_period: th_period,definitely: false)
    user.subjects.create!(name: name,day_of_week: "Friday",th_period: th_period,definitely: true)
    user.subjects.create!(name: name,day_of_week: "Saturday",th_period: th_period,definitely: false)
end 

(1..6).each do |n|
    name = "abcmarket-#{n}"
    th_period = n
    user = User.third
    user.subjects.create!(name: name,day_of_week: "Monday",th_period: th_period,definitely: true)
    user.subjects.create!(name: name,day_of_week: "Tuesday",th_period: th_period,definitely: false)
    user.subjects.create!(name: name,day_of_week: "Wednesday",th_period: th_period,definitely: true)
    user.subjects.create!(name: name,day_of_week: "Thursday",th_period: th_period,definitely: false)
    user.subjects.create!(name: name,day_of_week: "Friday",th_period: th_period,definitely: true)
    user.subjects.create!(name: name,day_of_week: "Saturday",th_period: th_period,definitely: false)
end 



(1..28).each do |n|
    time = n*3
    ctime = n*2
    dayb = Date.new(Date.today.year,Date.today.month-1,n)
    day = Date.new(Date.today.year,Date.today.month,n)
    daya = Date.new(Date.today.year,Date.today.month+1,n)
    user = User.first
    
    user.studytimes.create!(time: time,ctime: ctime,day: dayb)
    user.studytimes.create!(time: time,ctime: ctime,day: day)
    user.studytimes.create!(time: time,ctime: ctime,day: daya)
end 

(1..28).each do |n|
    time = n*3
    ctime = n*2
    dayb = Date.new(Date.today.year,Date.today.month-1,n)
    day = Date.new(Date.today.year,Date.today.month,n)
    daya = Date.new(Date.today.year,Date.today.month+1,n)
    user = User.second
    
    user.studytimes.create!(time: time,ctime: ctime,day: dayb)
    user.studytimes.create!(time: time,ctime: ctime,day: day)
    user.studytimes.create!(time: time,ctime: ctime,day: daya)

end 

(1..28).each do |n|
    time = n*3
    ctime = n*2
    dayb = Date.new(Date.today.year,Date.today.month-1,n)
    day = Date.new(Date.today.year,Date.today.month,n)
    daya = Date.new(Date.today.year,Date.today.month+1,n)
    user = User.third
    
    user.studytimes.create!(time: time,ctime: ctime,day: dayb)
    user.studytimes.create!(time: time,ctime: ctime,day: day)
    user.studytimes.create!(time: time,ctime: ctime,day: daya)

end 


User.first.notifications.create!(subject: "物理学",start_time: Date.tomorrow,homework_test: false,over: false)
(1..28).each do |n|
    subject = "subject-#{n}"
    start_time = DateTime.new(Date.today.year,Date.today.month,n,12,00,00)
    over = false
    user = User.first
    if n != Date.tomorrow.day 
        if n%2 == 0
            if n%3==0
                homework_test = true
                user.notifications.create!(subject: subject,start_time: start_time,homework_test: homework_test,over: over)
            else
                homework_test = false 
                user.notifications.create!(subject: subject,start_time: start_time,homework_test: homework_test,over: over)
            end         
        end 
    end
    
end 

(1..28).each do |n|
    subject = "subject-#{n}"
    start_time = DateTime.new(Date.today.year,Date.today.month,n,12,00,00)
    over = false
    user = User.second
    if n != Date.tomorrow.day 
        if n%2 == 0
            if n%3==0
                homework_test = true
                user.notifications.create!(subject: subject,start_time: start_time,homework_test: homework_test,over: over)
            else
                homework_test = false 
                user.notifications.create!(subject: subject,start_time: start_time,homework_test: homework_test,over: over)
            end         
        end 
    end
    
end 

(1..28).each do |n|
    subject = "subject-#{n}"
    start_time = DateTime.new(Date.today.year,Date.today.month,n,12,00,00)
    over = false
    user = User.third
    if n != Date.tomorrow.day 
        if n%2 == 0
            if n%3==0
                homework_test = true
                user.notifications.create!(subject: subject,start_time: start_time,homework_test: homework_test,over: over)
            else
                homework_test = false 
                user.notifications.create!(subject: subject,start_time: start_time,homework_test: homework_test,over: over)
            end         
        end 
    end
    
end 





    
    
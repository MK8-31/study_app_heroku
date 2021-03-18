# Study App
 
Study Appは大学生向けに作った時間管理アプリです。  
時間割登録をするついでに、予定管理や学習管理を同時にできたら便利だと思い作成しました。  
レスポンシブ対応しているのでスマホからもご確認いただけます。  

# URL
 
<https://www.study-app.tk>
  
  
# 使用技術
 
 
* Ruby 2.7.0
* ruby on rails 6.1.3
* Mysql 8.0
* Nginx
* Puma
* AWS
  * VPC
  * EC2
  * RDS
  * ELB
* Docker/Docker-compose
* RSpec
* jquery
* bootstrap

 
# 機能一覧
  
()内はapp/viewsにあるフォルダ名です。
* ユーザー登録、ログイン機能（users,sessions）
  * Action Mailer
  * Session機能
* 時間割(subjects)
* 予定表(notifications)
  * simple-calendar <- カレンダー
* 通知機能(reminders)
* 学習記録(studytimes)
  * ページネーション機能
  * chartkick <- グラフ機能
 
# テスト
 
* RSpec
  * 単体テスト(controllers,models)
  * 統合テスト(system)

 
# 機能について

通知はwhenever gemを使い、config/schedule.rbにlib/tasks/reminder.rakeを一日一回実行するように設定しているため行われます。

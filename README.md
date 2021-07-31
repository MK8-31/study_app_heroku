# Study App
 
Study Appは大学生向けに作った時間管理アプリです。  
時間割登録をするついでに、予定管理や学習管理を同時にできたら便利だと思い作成しました。  
レスポンシブ対応をしているのでスマホからもご確認いただけます。  
  
<img width="1265" alt="スクリーンショット 2021-03-18 9 35 53" src="https://user-images.githubusercontent.com/68171652/111556252-71124400-87cd-11eb-82a8-90fb5fc6187f.png">
<img width="242" alt="スクリーンショット 2021-03-18 9 38 54" src="https://user-images.githubusercontent.com/68171652/111556444-f85fb780-87cd-11eb-82f0-291fdb65a619.png">


# URL
 
https://intense-journey-27786.herokuapp.com
  
  
# 使用技術
 
 
* Ruby 2.7.
* ruby on rails 6.1.3
* Nginx
* Puma
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

通知はheroku scheduler を使いlib/tasks/reminder.rakeを一日一回実行するようにして行われます。

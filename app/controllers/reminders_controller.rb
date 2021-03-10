class RemindersController < ApplicationController
  
  def index
    @reminders = current_user.reminders.all
  end
  
end

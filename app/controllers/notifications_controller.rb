class NotificationsController < ApplicationController
    def index
      @notifications = Current.user.notifications.order(created_at: :desc)
      @unread_notifications = Current.user.notifications.where(read: false)
      
    end
  end
  
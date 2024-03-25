class NotificationsController < ApplicationController
    def index
      @notifications = Current.user.notifications.order(created_at: :desc)
      @unread_notifications = Current.user.notifications.where(read: false)
      @unread_notifications.update_all(read: true)
    end
  end
  
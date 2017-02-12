# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  recipient_id    :integer
#  actor_id        :integer
#  read_at         :datetime
#  action          :string
#  notifiable_id   :integer
#  notifiable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Notification < ApplicationRecord

  belongs_to :actor,     class_name: "User"  # A user who has triggered a notification.
  belongs_to :recipient, class_name: "User"  # A user who will receive that notification.

  belongs_to :notifiable, polymorphic: true  # Notifiable can be anything.

  scope :unread, ->{ where(read_at: nil) }
  scope :recent, ->{ order(created_at: :desc).limit(5) }

  def self.posted(actor:, recipient:, notifiable:)
    Notification.create!(action: "posted", recipient: recipient, actor: actor, notifiable: notifiable)
  end

  def self.follow(actor:, recipient:, notifiable:)
    Notification.create!(action: "follow", recipient: recipient, actor: actor, notifiable: notifiable)
  end

  def unread?
    !read_at
  end
end

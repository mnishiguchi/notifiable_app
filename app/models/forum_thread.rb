# == Schema Information
#
# Table name: forum_threads
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ForumThread < ApplicationRecord
  belongs_to :user

  # http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html#module-ActiveRecord::NestedAttributes::ClassMethods-label-Validating+the+presence+of+a+parent+model
  has_many :forum_posts, inverse_of: :forum_thread
  has_many :users, through: :forum_posts

  accepts_nested_attributes_for :forum_posts

  validates :title, presence: true
end

class Notification < ActiveRecord::Base
  belongs_to :project
  belongs_to :admin

  validates :admin,
            :project,
            :message, presence: true

  scope :without_updated, -> { where(updated: false) }
end

class Project < ActiveRecord::Base
  belongs_to :user

  validates :title,
            :description,
            :short_description, presence: true
end

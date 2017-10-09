class Project < ActiveRecord::Base
  include AASM

  IMAGE_DEFAULT_STYLES = { thumb: '64x64#', small: '470x470#' }

  has_many :notifications
  belongs_to :user
  belongs_to :admin

  validates :title,
            :description,
            :short_description, presence: true

  has_attached_file :image,
                    styles: IMAGE_DEFAULT_STYLES,
                    default_url: lambda { |file| file.instance.paperclip_set_default_url }
  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 0..2024.kilobytes
  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png)

  scope :without_admin, -> { where(admin: nil) }

  before_update :updates, if: :project_attrs_changed?

  def paperclip_set_default_url
    ActionController::Base.helpers.asset_url('missing.png')
  end

  enum status: {
    wait_comments: 1,
    with_comments: 2,
    accepted: 3
  }

  aasm column: :status, enum: true do
    state :wait_comments, initial: true
    state :with_comments, :accepted

    event :accept do
      transitions from: :wait_comments,
                  to: :accepted
    end

    event :not_accept do
      transitions from: :wait_comments,
                  to: :with_comments
    end

    event :updates do
      transitions from: [:wait_comments, :with_comments, :accepted],
                  to: :wait_comments,
                  after: :update_notifications!
    end
  end

  private

  def update_notifications!
    notifications.update_all(updated: true)
  end

  def project_attrs_changed?
    changed.any?{ |attr| ['title', 'short_description', 'description'].include?(attr) }
  end
end

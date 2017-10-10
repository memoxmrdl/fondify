class Project < ActiveRecord::Base
  include ProjectStatusMachine

  IMAGE_DEFAULT_STYLES = { thumb: '64x64#', small: '470x470#' }

  attr_accessor :admin_changes

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

  scope :without_admin, -> { where(admin_id: nil) }

  before_update :updates, if: [:admin_changes!, :project_attrs_changed?]

  def paperclip_set_default_url
    ActionController::Base.helpers.asset_url('missing.png')
  end

  def status_human
    I18n.t("enums.project_status.#{status}")
  end

  def admin_changes!
    !admin_changes
  end

  private

  def update_notifications!
    notifications.update_all(updated: true)
  end

  def project_attrs_changed?
    changed.any?{ |attr| ['title', 'short_description', 'description'].include?(attr) }
  end
end

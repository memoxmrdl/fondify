class Project < ActiveRecord::Base
  DEFAULT_STYLES = { thumb: '64x64#', small: '470x470#' }

  belongs_to :user

  validates :title,
            :description,
            :short_description, presence: true

  has_attached_file :image,
                    styles: DEFAULT_STYLES,
                    default_url: lambda { |file| file.instance.paperclip_set_default_url }
  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 0..2024.kilobytes
  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png)

  def paperclip_set_default_url
    ActionController::Base.helpers.asset_url('missing.png')
  end
end

module Pwb
  class ContentPhoto < ApplicationRecord
    mount_uploader :image, ContentPhotoUploader
    belongs_to :content, optional: true

    # validates_processing_of :image
    # validate :image_size_validation

    def optimized_image_url
      if Rails.application.config.use_cloudinary
        options = {height: 800, crop: "scale", quality: "auto"}
        image_url = Cloudinary::Utils.cloudinary_url self, options
      else
        image_url = self.image.url
      end
      image_url
    end

    # private
    # def image_size_validation
    #   errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
    # end
  end
end

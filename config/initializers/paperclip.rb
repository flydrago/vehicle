require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
Paperclip.interpolates :product do |attachment, style|
  product = attachment.instance.product
  unless product.blank?
    product.id
  end
end
class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      image.attach(io: File.open(file_path),filename:'default_image.jpg', centent_type:'image/jpeg')
    end
    image.variant(resize_to_limit:[width,height]).processed
  end

  # enum is_active: { "販売中": true, "販売停止中": false }

end

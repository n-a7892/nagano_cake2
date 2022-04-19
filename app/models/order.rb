class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  def shipping_cost_display
    800
  end

  def address_display
    "〒" + postal_code + " " + address
  end

  enum status: { waiting: 0, comfirm: 1, making: 2, preparation: 3, sent: 4 }
  enum payment_method: { credit_card: 0, transfer: 1 }
end

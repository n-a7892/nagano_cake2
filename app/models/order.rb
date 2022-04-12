class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customers

  enum status: { "入金待ち": 1, "入金確認": 2, "製作中": 3, "発送準備中": 4, "発送済み": 5 }
  enum payment_method: { "クレジットカード": 1, "銀行振込": 2 }
end

class OrderDetail < ApplicationRecord
  belongs_to :orders
  belongs_to :items

  enum making_status: { "着手不可": 1, "製作待ち": 2, "製作中": 3, "製作完了": 4 }
end

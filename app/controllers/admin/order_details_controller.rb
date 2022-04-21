class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    @order_details = @order.order_details
    if @order_details.where(making_status:2).any?
      @order.update(status: 2)
    else
      count = 0
      @order_details.each do |detail|
        if detail.making_status == "complete"
          count += 1
        end
      end
      if count == @order_details.count
        @order.update(status: 3)
      end
    end
    redirect_to admin_order_path(@order_detail.order_id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end

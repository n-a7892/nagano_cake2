class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.page(params[:page]).per(10)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details.all
    if @order.status == "comfirm"
      @order_details.each do |order_detail|
      order_detail.update(making_status:1)
      end
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :status, :payment_method, :shipping_cost, :total_payment)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end

end

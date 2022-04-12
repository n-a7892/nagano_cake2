class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
    # @order_detail = OrderDetail.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
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

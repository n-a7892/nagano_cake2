class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(10)
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def complete
  end

  def comfirm
    @cart_items = current_customer.cart_items.all
    @sum = 0
    @shipping_cost = 800
    @order = current_customer.orders.new(order_params)

    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_address] == "1"
      @address = current_customer.addresses.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:select_address] == "2"
      @order = current_customer.orders.new(order_params)
    end

  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cis|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cis.item_id
      @order_detail.price = cis.item.with_tax_price
      @order_detail.amount = cis.amount
      @order_detail.making_status = 1
      @order_detail.save
    end
    @cart_items.destroy_all
    redirect_to public_orders_complete_path
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end

end

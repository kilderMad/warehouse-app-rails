class OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :admin_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.admin = current_admin
    @order.save
    redirect_to @order, notice: 'Pedido registrado com sucesso'
  end

  def show
    @order = Order.find(params[:id])
  end
end
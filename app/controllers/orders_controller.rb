class OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    if current_admin
      @orders = current_admin.orders
    end
  end
  
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

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end
end
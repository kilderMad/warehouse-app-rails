class OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :check_user, only: [:show, :edit, :update, :delivered, :canceled]

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
    
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :admin_id, :estimated_delivery_date)
    
    if @order.update(order_params)
      redirect_to order_path, notice: 'Pedido atualizado com sucesso.'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      render :edit
    end
  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def canceled
    @order.canceled!
    redirect_to order_path
  end

  def delivered
    @order.delivered!
    redirect_to order_path
  end

  private

  def check_user
    @order = Order.find(params[:id])
    if @order.admin != current_admin
      return redirect_to root_path, notice: 'Pedido não existe'
    end
  end
end
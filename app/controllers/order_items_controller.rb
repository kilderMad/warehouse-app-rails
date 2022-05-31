class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @product_models = @order.supplier.product_models
  end

  def create
    @order = Order.find(params[:order_id])
    order_item_params = params.require(:order_item).permit(:product_model_id, :quantity)
    if @order_item = @order.order_items.create(order_item_params)
      redirect_to @order, notice: 'Item adicionado com sucesso'
    else
      @product_models = ProductModel.all
      flash[:notice] = "Falha ao adicionar"
      render :new
    end
  end
end
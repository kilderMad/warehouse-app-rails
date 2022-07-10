class Api::V1::StockProductsController < Api::V1::ApiController
  def stock_update
    params[:ids].each do |id|
      StockProduct.find(id).destroy
    end
  end
end

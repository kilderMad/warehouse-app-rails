class WarehousesController < ApplicationController
    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new
        @warehouse = Warehouse.new
    end

    def create
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :area, :cep)
        @warehouse = Warehouse.new(warehouse_params)
        if @warehouse.save()
            flash[:notice] = 'Galpão cadastrado com sucesso!'
            redirect_to root_path
        end
    end
end
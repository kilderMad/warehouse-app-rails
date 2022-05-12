class ProductModelsController < ApplicationController
    def index
        @product_models = ProductModel.all
    end

    def show
        @product_model = ProductModel.find(params[:id])
    end

    def new
        @product_model = ProductModel.new
    end

    def create
        product_model_params = params.require(:product_model).permit(:name, :wight, :width, :height, :depth, :supplier_id, :sku)

        @product_model = ProductModel.new(product_model_params)
        if @product_model.save
            redirect_to product_model_path(@product_model.id), notice: "Modelo de produto cadastrado com sucesso"
        else
            flash[:notice] = "Falha ao cadastrar, preencha os dados corretamente"
            render :new  
        end
    end

    def edit
        @product_model = ProductModel.find(params[:id])
    end

    def update
        @product_model = ProductModel.find(params[:id])
        product_model_params = params.require(:product_model).permit(:name, :wight, :width, :height, :depth, :supplier , :sku)
        if @product_model.update(product_model_params)
            redirect_to product_model_path, notice: "Modelo de produto atualizado com sucesso"
        else
            flash[:notice] = "Falha ao atualizar, preencha os dados corretamente"
            render :new
        end
    end
end
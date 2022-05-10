class SuppliersController < ApplicationController
    def index
        @suppliers = Supplier.all
    end

    def show
        @supplier = Supplier.find(params[:id])
    end

    def new
        @supplier = Supplier.new 
    end

    def create
        supplier_params = params.require(:supplier).permit(:fantasy_name, :company_name, :cnpj, :email, :phone, :address)
        @supplier = Supplier.new(supplier_params)
        if @supplier.save()
            
            redirect_to supplier_path(@supplier.id), notice: 'Fornecedor cadastrado com sucesso'
        else 
            flash.now[:notice] = 'Falha ao cadastrar'
            render :new
        end
    end

    def edit
        @supplier = Supplier.find(params[:id])
    end

    def update
        @supplier = Supplier.find(params[:id])
        supplier_params = params.require(:supplier).permit(:fantasy_name, :company_name, :cnpj, :email, :phone, :address)
        if @supplier.update(supplier_params)
            redirect_to supplier_path(params[:id]), notice: 'Fornecedor editado com sucesso'
        else
            flash.now[:notice] = 'Falha ao editar'
            render :edit
        end
    end
end
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
   @item = Item.find(params[:id])
   @order = Order.new
   p @item.inspect
   p "1111111"
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json

  def purchase
   @item = Item.find(params[:id])
   @order = Order.new
   p @item.inspect
   p "1111111"
  end

  def purchase_option
      @item = Item.find(params[:order][:id])
      @total_count=@item.price
      amount_to_charge = @total_count * 100

      if params[:order][:card_type] =="Master Card"
        brand = 'master'
      elsif params[:order][:card_type] =="Discover"
        brand = 'discover'
      elsif params[:order][:card_type] =="American Express"
        brand = 'american_express'
      else
        brand = 'visa'
      end

    credit_card = ActiveMerchant::Billing::CreditCard.new(
        :brand              => "#{brand}",
        :number             => "#{params[:order][:cardnumber_1]}" + "#{params[:order][:cardnumber_2]}" + "#{params[:order][:cardnumber_3]}" + "#{params[:order][:cardnumber_4]}",
        :verification_value => params[:order][:cardnumber_5],
        :year              => params[:order]["card_expires_on(1i)"],
        :month               => params[:order]["card_expires_on(2i)"],
        :first_name         => params[:order][:first_name],
        :last_name          => params[:order][:last_name]
      )
    p   amount_to_charge = @total_count * 100
    p "---------"

      if credit_card.valid?
        response = GATEWAY.authorize(amount_to_charge, credit_card, :billing_address =>
            {
              :name =>"#{params[:order][:first_name]}" + "#{params[:order][:last_name]}",
              :address1 => "#{params[:order][:address]}",
              :city => params[:order][:city],
              :state =>  params[:order][:state],
              :country =>params[:order][:country],
              :zip => params[:order][:zip_code],
              :phone => params[:order][:phone_no]
              } )
        if response.success?
          p "&&&&&&&&&&&&&&&&&&&"
          @order=Order.new
          @order.item_id=@item.id,
          @order.created_user_id=@item.user_id,
          @order.purchased_user_id=current_user.user_id,
          @order.first_name=params[:order][:first_name],
          @order.last_name=params[:order][:last_name],
          @order.card_type=params[:order][:card_type],
          @order.card_number="#{params[:order][:cardnumber_1]}" + "#{params[:order][:cardnumber_2]}" + "#{params[:order][:cardnumber_3]}" + "#{params[:order][:cardnumber_4]}",
          @order.card_verification=params[:order][:cardnumber_5],
          @order.address=params[:order][:address],
          @order.city=params[:order][:city],
          @order.state=params[:order][:state],
          @order.country=params[:order][:country],
          @order.zipcode=params[:order][:zipcode],
          @order.phone=params[:order][:phone_no],
          @order.save
          # if @order.save
          #   p "**********************************"
          #   @item.available=@item.available-1
          #   @item.save
          # end
          par = GATEWAY.capture(amount_to_charge, response.authorization)
          p par.inspect
          @message=response.message
          p "1111111111"
        else
          p @message=response.message
          p "2222222222"
        end
      else
          p "333333333"
          p @message= "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
      end
       respond_to do |format|
       format.js
    end
  end
  

def create
  @order = current_cart.build_order(params[:order])
  @order.ip_address = request.remote_ip
  if @order.save
    if @order.purchase
      render :action => "success"
    else
      render :action => "failure"
    end
  else
    render :action => 'new'
  end
end

  def createold
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:new, :cart_id, :ip_address, :first_name, :last_name, :card_type, :card_expires_on, :card_number, :card_verification)
    end
end

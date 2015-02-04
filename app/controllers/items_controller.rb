class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  require 'active_merchant'
  require 'authorize_net'

  # GET /items
  # GET /items.json
  def index
    
    @categories = Category.all
    if !params[:filter].nil? && params[:filter]=="yes"
       item = Item.where("category_id=?",params[:category_id]).order("name asc")
       @items= item.paginate(:page => params[:page], :per_page => 3)
    elsif 
      item = Item.all.order("name asc")
      @items=item#.paginate(:page => params[:page], :per_page => 5)
    end
    respond_to do |format|
       format.js
       format.html
    end
  end


  # GET /items/1
  # GET /items/1.json
  def show
    @user=User.find_by_user_id(@item.user_id)
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params.merge(:user_id => current_user.user_id))

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end


def purchase
 @item = Item.find(params[:id])
end

def purchase_option
      @item = Item.find(params[:item][:id])
      # @total_count=@item.price
      # amount_to_charge = @total_count * 100
    p  @item.inspect
    p  @total_count=@item.price - @item.discount
    p  earn_admin=@total_count/10
    p  earn_own=@total_count-earn_admin
    p  amount_to_charge = @total_count * 100
    p "---------"

      if params[:item][:card_type] =="Master Card"
        brand = 'master'
      elsif params[:item][:card_type] =="Discover"
        brand = 'discover'
      elsif params[:item][:card_type] =="American Express"
        brand = 'american_express'
      else
        brand = 'visa'
      end

    credit_card = ActiveMerchant::Billing::CreditCard.new(
        :brand              => "#{brand}",
        :number             => "#{params[:item][:cardnumber_1]}" + "#{params[:item][:cardnumber_2]}" + "#{params[:item][:cardnumber_3]}" + "#{params[:item][:cardnumber_4]}",
        :verification_value => params[:item][:cardnumber_5],
        :year              => params[:item]["card_expires_on(1i)"],
        :month               => params[:item]["card_expires_on(2i)"],
        :first_name         => params[:item][:first_name],
        :last_name          => params[:item][:last_name]
      )
   

      if credit_card.valid?
        response = GATEWAY.authorize(amount_to_charge, credit_card, :billing_address =>
            {
              :name =>"#{params[:item][:first_name]}" + "#{params[:item][:last_name]}",
              :address1 => "#{params[:item][:address]}",
              :city => params[:item][:city],
              :state =>  params[:item][:state],
              :country =>params[:item][:country],
              :zip => params[:item][:zip_code],
              :phone => params[:item][:phone_no]
              } )
        if response.success?
          p "^^^^^^^^^^"
          @order=Order.new
          @order.item_id=@item.id,
          @order.created_user_id=@item.user_id,
          @order.purchased_user_id=current_user.user_id,
          @order.first_name=params[:item][:first_name],
          @order.last_name=params[:item][:last_name],
          @order.card_type=params[:item][:card_type],
          @order.card_number="#{params[:item][:cardnumber_1]}" + "#{params[:item][:cardnumber_2]}" + "#{params[:item][:cardnumber_3]}" + "#{params[:item][:cardnumber_4]}",
          @order.card_verification=params[:item][:cardnumber_5],
          @order.address=params[:item][:address],
          @order.city=params[:item][:city],
          @order.state=params[:item][:state],
          @order.country=params[:item][:country],
          @order.zipcode=params[:item][:zipcode],
          @order.phone=params[:item][:phone_no],
          @order.save!
          if @order.save
            p @item.available
            p "**********************************"
            @user_credit = UserCredit.new(:created_user_id => @item.user_id, :purchased_user_id => current_user.user_id, :item_id => @item.id, :credit_amount => earn_own, :admin_credit_amount => earn_admin)
            @user_credit.save
           
             @item.update_attribute(:available, @item.available - 1)
             p @item.inspect
          end

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
  
  
  def category_filter
    if !params[:filter].nil? && params[:filter]=="yes"
       if !params[:category_id].nil? && params[:category_id]=="all"
          @items = Item.all.order("name asc")
       else
          @items = Item.where("category_id=?",params[:category_id]).order("name asc")
      end
    end
    respond_to do |format|
       format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :discription, :price, :discount, :category_id, :user_id, :available,:avatar)
    end
end

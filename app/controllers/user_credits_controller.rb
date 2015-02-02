class UserCreditsController < ApplicationController
  before_action :set_user_credit, only: [:show, :edit, :update, :destroy]

  # GET /user_credits
  # GET /user_credits.json
  def index
    @user_credits = UserCredit.all
    @users=User.all
  end

  # GET /user_credits/1
  # GET /user_credits/1.json
  def show
  end

  # GET /user_credits/new
  def new
    @user_credit = UserCredit.new
  end

  # GET /user_credits/1/edit
  def edit
  end

  # POST /user_credits
  # POST /user_credits.json
  def create
    @user_credit = UserCredit.new(user_credit_params)


    respond_to do |format|
      if @user_credit.save
        format.html { redirect_to @user_credit, notice: 'User credit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_credit }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_credits/1
  # PATCH/PUT /user_credits/1.json
  def update
    respond_to do |format|
      if @user_credit.update(user_credit_params)
        format.html { redirect_to @user_credit, notice: 'User credit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_credits/1
  # DELETE /user_credits/1.json
  def destroy
    @user_credit.destroy
    respond_to do |format|
      format.html { redirect_to user_credits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_credit
      @user_credit = UserCredit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_credit_params
      params.require(:user_credit).permit(:created_user_id, :purchased_user_id, :item_id, :credit)
    end
end

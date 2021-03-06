class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :ablys_members, :matrimony_list, :ncc_members, :get_cities]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  caches_page :show

  # GET /users
  # GET /users.json
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page params[:page]
    @total = @users.total_count
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def ablys_members
    @users = User.where(is_ablys_member: true).reorder("is_active desc")
  end

  # GET /users/1/edit
  def edit
  end

  def matrimony_list
    @search = User.where("is_matrimony = true AND marital_status != 'Married' ").ransack(params[:q])
    @users = @search.result(distinct: true).page params[:page]
    @total = @users.total_count
  end

  def ncc_members
  end

  def get_cities
    @cities = City.where(state: params[:state]).pluck(:name)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :dob, :f_name, :gender, :email, :address, :city, :state, :country, :pin_code, :phone, :is_matrimony, :avatar,
        :gotra, :marital_status, :qualification, :designation, :company_name, :income,
        :username, :serial_number)
    end
end

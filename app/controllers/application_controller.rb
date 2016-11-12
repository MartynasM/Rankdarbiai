class ApplicationController < ActionController::Base
  include CurrentCart
  before_action :set_cart
  protect_from_forgery with: :exception
  before_action :set_categories
  after_filter :store_action
  before_filter :current_cart
helper_method :current_cart

def current_cart
   @current_cart = session[:cart_id] ? Cart.find(session[:cart_id]) : Cart.create
   session[:cart_id] = @current_cart.id if @current_cart.new_record?
 end
 def decrease
   @cart = current_cart
   @line_item = @cart.decrease(params[:id])

   respond_to do |format|
     if @line_item.save
       format.html { redirect_to store_index_path, notice: 'Item was successfully updated.' }
       format.js { @current_item = @line_item }
       format.json { head :ok }
     else
       format.html { render action: "edit" }
       format.json { render json: @line_item.errors, status: :unprocessable_entity}
     end
   end
 end

 def increase
   @cart = current_cart
   @line_item = @cart.increase(params[:id])

   respond_to do |format|
     if @line_item.save
       format.html { redirect_to store_path, notice: 'Item was successfully updated.' }
       format.js   { @current_item = @line_item }
       format.json { head :ok }
     else
       format.html { render action: "edit" }
       format.json { render json: @line_item.errors, status: :unprocessable_entity }
     end
   end
 end

  def set_categories
    @categories = Category.all
  end

  def store_action
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      store_location_for(:user, request.fullpath)
    end
  end

  def require_admin
    unless current_user.class == AdminUser
      flash[:error] = "You are not an admin"
      redirect_to store_index_path
    end
  end

end

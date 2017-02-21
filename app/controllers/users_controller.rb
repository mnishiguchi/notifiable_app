class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users       = User.all
    @user_import = User::Import.new

    respond_to do |format|
      format.html {}
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  # POST /users/import(.:format)
  def import
    # raise params[:file]

    @user_import = User::Import.new(user_import_params)

    # Try to import the specified file.
    if @user_import.save
      flash[:success] = "Imported #{@user_import.imported_count} users"
      redirect_to users_url
    else
      @users = User.all  # Provide users because we re-render users/index view.
      flash.now[:alert] = "There were #{view_context.pluralize(@user_import.errors.count, "error")} importing your CSV file"
      render action: :index
    end

    # NOTE: Rails can handle file uploads without CarrierWave or PapaerClip but
    # the loaded file is saved in a temp file.
    # The temp file object is stored in params[:file].
    # If we need to look up the loaded file again later, we will enjoy the benefit of
    # using those third party libraries.
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
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
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
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
      params.fetch(:user, {})
    end

    def user_import_params
      params.fetch(:user_import, {}).permit(:file)
      # NOTE: When params are empty, the following exception will be raised:
      # ActionController::ParameterMissing - param is missing or the value is empty: user_import: ...
      # To avoid that, provide a default {} using fetch instead of require.
      # http://guides.rubyonrails.org/action_controller_overview.html#more-examples
    end
end

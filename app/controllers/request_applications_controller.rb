class RequestApplicationsController < ApplicationController
  before_action :set_request_application, only: [:show, :edit, :update, :destroy]

  # GET /request_applications
  # GET /request_applications.json
  def index
    @request_applications = RequestApplication.all
    @flow_orders = FlowOrder.order_list
  end

  # GET /request_applications/1
  # GET /request_applications/1.json
  def show
  end

  # GET /request_applications/new
  def new
    @request_application = RequestApplication.new
  end

  # GET /request_applications/1/edit
  def edit
  end

  # POST /request_applications
  # POST /request_applications.json
  def create
    @request_application = RequestApplication.new(request_application_params)
    @flow = @request_application.flows.build
    @flow.first

    respond_to do |format|
      if @request_application.save && @flow.save
        format.html { redirect_to @request_application, notice: 'Request application was successfully created.' }
        format.json { render :show, status: :created, location: @request_application }
      else
        format.html { render :new }
        format.json { render json: @request_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_applications/1
  # PATCH/PUT /request_applications/1.json
  def update
    respond_to do |format|
      if @request_application.update(request_application_params)
        format.html { redirect_to @request_application, notice: 'Request application was successfully updated.' }
        format.json { render :show, status: :ok, location: @request_application }
      else
        format.html { render :edit }
        format.json { render json: @request_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_applications/1
  # DELETE /request_applications/1.json
  def destroy
    @request_application.destroy
    respond_to do |format|
      format.html { redirect_to request_applications_url, notice: 'Request application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request_application
    @request_application = RequestApplication.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_application_params
    params.require(:request_application).permit(:management_no, :emargency, :filename, :request_date, :preferred_date, :close, :project_id)
  end
end

class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, :only => :create_from_lff_site
  protect_from_forgery :except => [:create_from_lff_site]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.order(created_at: :desc)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_from_lff_site
    puts params
    @message = Message.new
    @message.first_name = params[:first_name]
    @message.last_name = params[:last_name]
    @message.org_name = params[:org_name]
    @message.email = params[:email_address]
    @message.phone = params[:phone_number]
    @message.message = params[:message]

    if params[:extra_info].present?
      url = request.env["HTTP_REFERER"] + "?success=false"
      redirect_to url
    else
      if @message.save
        MessageMailer.new_message_notification(@message).deliver_now
        # msg = {:status => 'success'}
        url = request.env["HTTP_REFERER"] + "?success=true"
        redirect_to url
      else
        url = request.env["HTTP_REFERER"] + "?success=false"
        redirect_to url
      end
    end

  end


  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:first_name, :last_name, :org_name, :email, :phone, :message)
    end
end

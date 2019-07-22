class ScrappingTasksController < ApplicationController
  before_action :set_current_session
  before_action :set_scrapping_task, only: [:show, :edit, :update, :destroy]

  # GET /scrapping_tasks
  # GET /scrapping_tasks.json
  def index
    @scrapping_tasks = ScrappingTask.by_session(current_session).all
  end

  # GET /scrapping_tasks/1
  # GET /scrapping_tasks/1.json
  def show
  end

  # GET /scrapping_tasks/new
  def new
    @scrapping_task = ScrappingTask.by_session(current_session).new
  end

  # GET /scrapping_tasks/1/edit
  def edit
  end

  # POST /scrapping_tasks
  # POST /scrapping_tasks.json
  def create
    @scrapping_task = ScrappingTask.by_session(current_session).new(scrapping_task_params)

    respond_to do |format|
      if @scrapping_task.save
        format.html { redirect_to @scrapping_task, notice: 'Scrapping task was successfully created.' }
        format.js { render :show }
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /scrapping_tasks/1
  # PATCH/PUT /scrapping_tasks/1.json
  def update
    respond_to do |format|
      if @scrapping_task.update(scrapping_task_params)
        format.html { redirect_to @scrapping_task, notice: 'Scrapping task was successfully updated.' }
        format.json { render :show, status: :ok, location: @scrapping_task }
      else
        format.html { render :edit }
        format.json { render json: @scrapping_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrapping_tasks/1
  # DELETE /scrapping_tasks/1.json
  def destroy
    @scrapping_task.destroy
    respond_to do |format|
      format.html { redirect_to scrapping_tasks_url, notice: 'Scrapping task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_current_session
      if cookies[:screenshot_taker_session_id].blank?
        cookies[:screenshot_taker_session_id] = SecureRandom.uuid
      end
    end

    def current_session
      cookies[:screenshot_taker_session_id]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_scrapping_task
      @scrapping_task = ScrappingTask.by_session(current_session).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrapping_task_params
      params.require(:scrapping_task).permit(:name)
    end
end

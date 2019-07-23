class ScrappingTasksController < ApplicationController
  # GET /scrapping_tasks/new
  def new
    @scrapping_task = ScrappingTask.new
  end

  # POST /scrapping_tasks
  # POST /scrapping_tasks.json
  def create
    Rails.logger.info(scrapping_task_params)
    @scrapping_task = ScrappingTask.new(scrapping_task_params)

    respond_to do |format|
      if @scrapping_task.save
        ScrapeProviderSitesJob.perform_later(@scrapping_task.reload.id)
        format.html { redirect_to @scrapping_task, notice: 'Scrapping task was successfully created.' }
        format.js { render :show }
      else
        format.html { render :new }
        format.js
      end
    end
  end

  private
    def scrapping_task_params
      params.require(:scrapping_task).permit(:name)
    end
end

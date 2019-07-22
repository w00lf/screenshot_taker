class ScrappingTaskChannel < ApplicationCable::Channel
  def subscribed
    stream_from "scrapping_task_#{params[:uuid]}"
  end
end
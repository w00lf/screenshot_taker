class ScrapeProviderSitesJob < ApplicationJob
  queue_as :default

  def perform(scrapping_task_id)
    scrapping_task = ScrappingTask.find(scrapping_task_id)
    ActionCable.server.broadcast "scrapping_task_#{scrapping_task.uuid}", image_url: 'https://www.belightsoft.com/products/imagetricks/img/core-image-filters@2x.jpg', url: 'http://google.com'
  end
end
